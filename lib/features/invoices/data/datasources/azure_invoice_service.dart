import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/constants/azure_constants.dart';
import '../models/scanned_invoice_item.dart';
import '../../../../core/utils/text_normalizer.dart';
import '../../../../core/utils/pricing_helper.dart';

@lazySingleton
class AzureInvoiceService {
  final Dio _dio = Dio();

  Future<List<ScannedInvoiceItem>> scanInvoice(File imageFile) async {
    try {
      final String url =
          '${AzureConstants.endpoint}documentintelligence/documentModels/${AzureConstants.modelId}:analyze?api-version=${AzureConstants.apiVersion}';

      // Read file bytes
      final List<int> imageBytes = await imageFile.readAsBytes();

      // 1. Initial POST Request
      // We accept 200 or 202.
      final Response response = await _dio.post(
        url,
        data: Stream.fromIterable([imageBytes]), // Stream for binary data
        options: Options(
          headers: {
            'Ocp-Apim-Subscription-Key': AzureConstants.apiKey,
            'Content-Type': 'application/octet-stream',
          },
          responseType: ResponseType.json,
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      // 2. Handle Immediate Success (200)
      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData is String) {
          responseData = jsonDecode(responseData);
        }
        return _parseInvoiceJson(responseData as Map<String, dynamic>);
      }

      // 3. Handle Long-Running Operation (202 Accepted)
      if (response.statusCode == 202) {
        // Extract Operation-Location URL
        final String? operationLocation = response.headers.value(
          'Operation-Location',
        );

        if (operationLocation == null) {
          throw Exception(
            'Azure returned 202 Accepted but missing Operation-Location header.',
          );
        }

        // 4. Polling Loop
        String status = 'running';
        Map<String, dynamic>? finalResult;
        int maxRetries = 60; // Timeout approx 60 seconds
        int attempts = 0;

        while (status == 'running' || status == 'notStarted') {
          if (attempts >= maxRetries) {
            throw Exception('Azure Invoice Scan Polling Timed Out.');
          }

          await Future.delayed(const Duration(seconds: 1));
          attempts++;

          // Poll the status
          final Response pollResponse = await _dio.get(
            operationLocation,
            options: Options(
              headers: {'Ocp-Apim-Subscription-Key': AzureConstants.apiKey},
              responseType: ResponseType.json,
            ),
          );

          var pollData = pollResponse.data;
          if (pollData is String) {
            pollData = jsonDecode(pollData);
          }
          final Map<String, dynamic> dataMap = pollData as Map<String, dynamic>;

          status = dataMap['status'] ?? 'failed';

          if (status == 'succeeded') {
            finalResult = dataMap;
            break; // Exit loop to parse
          } else if (status == 'failed' || status == 'canceled') {
            throw Exception('Azure Invoice Scan Operation Failed: $status');
          }
          // Continue looping if running/notStarted
        }

        if (finalResult != null) {
          return _parseInvoiceJson(finalResult);
        }
      }

      throw Exception(
        'Azure API Failed with unexpected status: ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Azure Invoice Scan Failed: $e');
    }
  }

  List<ScannedInvoiceItem> _parseInvoiceJson(Map<String, dynamic> json) {
    List<ScannedInvoiceItem> finalItems = [];

    // Azure AI Document Intelligence structure:
    // analyzeResult -> documents -> [0] -> fields -> Items -> valueArray

    List<dynamic>? itemsArray;

    try {
      if (json.containsKey('analyzeResult')) {
        final documents = json['analyzeResult']['documents'] as List?;
        if (documents != null && documents.isNotEmpty) {
          final fields = documents[0]['fields'] as Map<String, dynamic>?;
          if (fields != null && fields.containsKey('Items')) {
            itemsArray = fields['Items']['valueArray'] as List?;
          }
        }
      }

      // Fallback or simplified structures
      if (itemsArray == null && json.containsKey('Items')) {
        final itemsMap = json['Items'] as Map<String, dynamic>;
        itemsArray = itemsMap['valueArray'] as List?;
      }
    } catch (e) {
      // Structure mismatch
      return [];
    }

    if (itemsArray == null) return [];

    for (var item in itemsArray) {
      try {
        if (item is! Map<String, dynamic>) continue;

        final valueObject = item['valueObject'] as Map<String, dynamic>?;
        if (valueObject == null) continue;

        // 1. Extract Raw Data
        String rawName = '';
        if (valueObject.containsKey('Description')) {
          rawName = valueObject['Description']['valueString']?.toString() ?? '';
        }
        // Basic clean to single spaces
        rawName = rawName.replaceAll(RegExp(r'\s+'), ' ').trim();

        if (rawName.isEmpty) continue;

        int quantity = 1;
        if (valueObject.containsKey('Quantity')) {
          quantity =
              (valueObject['Quantity']['valueNumber'] as num?)?.toInt() ?? 1;
        }

        double costPrice = 0.0;
        if (valueObject.containsKey('UnitPrice')) {
          final unitPriceObj = valueObject['UnitPrice'] as Map<String, dynamic>;
          if (unitPriceObj.containsKey('valueCurrency')) {
            costPrice =
                (unitPriceObj['valueCurrency']['amount'] as num?)?.toDouble() ??
                0.0;
          } else if (unitPriceObj.containsKey('valueNumber')) {
            costPrice =
                (unitPriceObj['valueNumber'] as num?)?.toDouble() ?? 0.0;
          }
        }

        double azureTotal = 0.0;
        if (valueObject.containsKey('Amount')) {
          final amountObj = valueObject['Amount'] as Map<String, dynamic>;
          if (amountObj.containsKey('valueCurrency')) {
            azureTotal =
                (amountObj['valueCurrency']['amount'] as num?)?.toDouble() ??
                0.0;
          } else if (amountObj.containsKey('valueNumber')) {
            azureTotal = (amountObj['valueNumber'] as num?)?.toDouble() ?? 0.0;
          }
        }

        // --- Logic A: Split Merged Rows (Multi-Publisher Detection) ---
        List<Map<String, dynamic>> pendingItems = [];

        // 1. Find all publisher matches in the raw string
        List<int> publisherIndices = [];
        for (final pub in TextNormalizer.knownPublishers) {
          // We use simple indexOf here. While normalization is better,
          // strict adherence to the requested logic suggests searching for
          // the known list strings. We find ALL occurrences (e.g. "Gem ... Gem").
          int index = rawName.indexOf(pub);
          while (index != -1) {
            publisherIndices.add(index);
            index = rawName.indexOf(pub, index + 1);
          }
        }
        publisherIndices.sort();

        // 2. Determine Split Point
        // We look for the first publisher index that is "secondary" (i.e. not at the start)
        int? splitIndex;
        for (final idx in publisherIndices) {
          if (idx > 5) {
            splitIndex = idx;
            break; // Split at the first valid secondary publisher
          }
        }

        // 3. Execute Split or Pass Through
        if (splitIndex != null) {
          final firstPart = rawName.substring(0, splitIndex).trim();
          final secondPart = rawName.substring(splitIndex).trim();

          // Add First Item (Inherits Qty & Price)
          pendingItems.add({
            'name': firstPart,
            'qty': quantity,
            'cost': costPrice,
            'total': azureTotal,
          });

          // Add Second Item (Unknown Qty/Price, default 1 & 0)
          pendingItems.add({
            'name': secondPart,
            'qty': 1,
            'cost': 0.0,
            'total': 0.0,
          });
        } else {
          pendingItems.add({
            'name': rawName,
            'qty': quantity,
            'cost': costPrice,
            'total': azureTotal,
          });
        }

        // --- Logic B & Finalization ---
        for (var pItem in pendingItems) {
          String pName = pItem['name'];
          int pQty = pItem['qty'];
          double pCost = pItem['cost'];
          double pTotal = pItem['total'];

          // Logic B: Split Quantity from Name (e.g., "5 Al-Adwaa...")
          final qtyMatch = RegExp(r'^(\d+)\s+(.+)').firstMatch(pName);
          if (qtyMatch != null) {
            final extractedQty = int.tryParse(qtyMatch.group(1)!);
            if (extractedQty != null) {
              pQty = extractedQty;
              pName = qtyMatch.group(2)!.trim();
            }
          }

          // Final Normalize
          final normalizedName = TextNormalizer.reconstructBookName(pName);
          if (normalizedName.isEmpty) continue;

          // Pricing Logic
          double sellingPrice = PricingHelper.calculateSellingPrice(
            pCost,
            normalizedName,
          );

          // Validation
          double myTotal = pQty * pCost;
          // Only check mismatch if we actually have a total from Azure (non-zero)
          // and if this wasn't a secondary split item (which has 0 total)
          bool hasMismatch = false;
          if (pTotal > 0) {
            hasMismatch = (myTotal - pTotal).abs() > 0.05;
          }

          finalItems.add(
            ScannedInvoiceItem(
              bookName: normalizedName,
              quantity: pQty,
              costPrice: pCost,
              sellingPrice: sellingPrice,
              hasCalculationMismatch: hasMismatch,
            ),
          );
        }
      } catch (e) {
        print('Failed to parse an item: $e');
        continue;
      }
    }

    return finalItems;
  }
}
