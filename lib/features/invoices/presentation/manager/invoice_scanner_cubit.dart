import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/datasources/azure_invoice_service.dart';

import '../../domain/models/scanned_item_model.dart';
import '../../../inventory/domain/repositories/inventory_repository.dart';
import '../../../../core/database/app_database.dart';
import '../../../../core/utils/text_normalizer.dart';

import 'package:get_it/get_it.dart';
import 'package:librarymanager/features/inventory/presentation/manager/inventory_cubit.dart';

import '../../domain/services/invoice_parser_service.dart';

part 'invoice_scanner_state.dart';

@injectable
class InvoiceScannerCubit extends Cubit<InvoiceScannerState> {
  final AzureInvoiceService _azureInvoiceService;
  final InventoryRepository _inventoryRepository;
  final InvoiceParserService _parser = InvoiceParserService();

  InvoiceScannerCubit(this._azureInvoiceService, this._inventoryRepository)
    : super(InvoiceScannerState(invoiceDate: DateTime.now()));

  void selectSupplier(Supplier supplier) {
    emit(state.copyWith(selectedSupplier: supplier));
  }

  void updateDate(DateTime date) {
    emit(state.copyWith(invoiceDate: date));
  }

  Future<void> processImage(File image, {bool isAppending = false}) async {
    emit(state.copyWith(status: InvoiceScannerStatus.scanning));
    try {
      final scannedInvoiceItems = await _azureInvoiceService.scanInvoice(image);

      if (scannedInvoiceItems.isEmpty) {
        String msg = 'لم يتم التعرف على الفاتورة';
        emit(
          state.copyWith(
            status: isAppending
                ? InvoiceScannerStatus.reviewing
                : InvoiceScannerStatus.error,
            errorMessage: msg,
          ),
        );
      } else {
        // Map DTO to Domain with Logic
        final domainItems = scannedInvoiceItems.map((dto) {
          // Use Parser Service for Logic (Pricing, Naming, etc.)
          final lineToParse =
              '${dto.bookName} ${dto.quantity} ${dto.costPrice}';
          final parsedItem = _parser.parseLine(lineToParse);

          if (parsedItem != null) {
            return parsedItem.copyWith(
              hasCalculationMismatch: dto.hasCalculationMismatch,
            );
          }

          // Fallback if parser fails
          final normalizedName = TextNormalizer.standardizeBookName(
            dto.bookName,
          );
          final calculatedSellPrice = double.parse(
            (dto.costPrice / 0.82).toStringAsFixed(2),
          );

          return ScannedItemModel(
            name: normalizedName,
            quantity: dto.quantity,
            price: dto.costPrice,
            sellPrice: calculatedSellPrice,
            hasCalculationMismatch: dto.hasCalculationMismatch,
            code: null,
          );
        }).toList();

        final combinedItems = isAppending
            ? [...state.scannedItems, ...domainItems]
            : domainItems;

        emit(
          state.copyWith(
            status: InvoiceScannerStatus.reviewing,
            scannedItems: combinedItems,
          ),
        );
      }
    } catch (e) {
      String msg = 'حدث خطأ: $e';
      if (e.toString().contains('Azure API Failed')) {
        msg = 'فشل الاتصال بخدمة تحليل الفواتير. تحقق من الإنترنت.';
      }
      emit(
        state.copyWith(
          status: isAppending
              ? InvoiceScannerStatus.reviewing
              : InvoiceScannerStatus.error,
          errorMessage: msg,
        ),
      );
    }
  }

  void addManualItem(ScannedItemModel item) {
    // Determine target list: if initial/scanning, create new list. If reviewing, append.
    // Actually we should arguably transition to 'reviewing' if we add an item manually.
    final currentList = List<ScannedItemModel>.from(state.scannedItems);
    currentList.add(item);

    emit(
      state.copyWith(
        status: InvoiceScannerStatus.reviewing,
        scannedItems: currentList,
      ),
    );
  }

  void updateScannedItem(int index, {String? name, int? qty, double? cost}) {
    final currentList = state.scannedItems;

    if (index >= 0 && index < currentList.length) {
      final oldItem = currentList[index];

      final newName = name ?? oldItem.name;
      final newQty = qty ?? oldItem.quantity;
      final newCost = cost ?? oldItem.price;

      // Recalc selling price if cost changed
      double? newSellPrice = oldItem.sellPrice;
      if (cost != null) {
        // cost / 0.82
        // Using simplified calculation as per previous logic
        newSellPrice = double.tryParse((newCost / 0.82).toStringAsFixed(2));
      }

      final updatedItem = ScannedItemModel(
        code: oldItem.code,
        name: newName,
        quantity: newQty,
        price: newCost,
        sellPrice: newSellPrice,
        hasCalculationMismatch: false,
      );

      final updatedList = List<ScannedItemModel>.from(currentList);
      updatedList[index] = updatedItem;

      emit(state.copyWith(scannedItems: updatedList));
    }
  }

  void updateItem(int index, ScannedItemModel updatedItem) {
    var updatedList = List<ScannedItemModel>.from(state.scannedItems);
    if (index >= 0 && index < updatedList.length) {
      updatedList[index] = updatedItem;
      emit(state.copyWith(scannedItems: updatedList));
    }
  }

  void removeItem(int index) {
    final updatedList = List<ScannedItemModel>.from(state.scannedItems);
    if (index >= 0 && index < updatedList.length) {
      updatedList.removeAt(index);
      emit(state.copyWith(scannedItems: updatedList));
    }
  }

  Future<void> confirmAndSaveItems(
    double discountPercentage, {
    double paidAmount = 0.0,
  }) async {
    if (state.selectedSupplier == null) {
      emit(
        state.copyWith(
          status: InvoiceScannerStatus.error,
          errorMessage: 'يرجى اختيار المورد أولاً',
        ),
      );
      return;
    }

    // We can save even if not strictly in "reviewing" status, as long as we have items?
    // But usually we are in reviewing.
    final currentItems = state.scannedItems;
    if (currentItems.isEmpty) return;

    try {
      emit(
        state.copyWith(status: InvoiceScannerStatus.scanning),
      ); // Loading style

      double totalCost = 0;
      for (final item in currentItems) {
        totalCost += (item.price * item.quantity);
      }

      final discountValue = double.parse(
        (totalCost * (discountPercentage / 100)).toStringAsFixed(2),
      );

      await _inventoryRepository.createPurchaseInvoice(
        state.selectedSupplier!.id,
        currentItems,
        discountValue,
        state.invoiceDate,
        paidAmount: paidAmount,
      );

      emit(
        state.copyWith(
          status: InvoiceScannerStatus.success,
          successMessage: 'تم حفظ الفاتورة بنجاح',
        ),
      );

      // Trigger Inventory Refresh
      if (GetIt.I.isRegistered<InventoryCubit>()) {
        GetIt.I<InventoryCubit>().loadBooks(isRefresh: true);
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: InvoiceScannerStatus.error,
          errorMessage: 'فشل الحفظ: $e',
        ),
      );
    }
  }

  void reset() {
    emit(InvoiceScannerState(invoiceDate: DateTime.now()));
  }
}
