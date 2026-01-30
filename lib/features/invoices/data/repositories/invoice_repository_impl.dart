import 'dart:io';
import 'package:injectable/injectable.dart';
import '../../domain/models/scanned_item_model.dart';
import '../../domain/repositories/invoice_repository.dart';

@LazySingleton(as: InvoiceRepository)
class InvoiceRepositoryImpl implements InvoiceRepository {
  @override
  Future<List<ScannedItemModel>> scanInvoiceImage(File image) async {
    // Placeholder for Azure AI Document Intelligence migration
    // Currently returns a Not Implemented state or empty list as per strict instructions to remove legacy logic.
    await Future.delayed(
      const Duration(seconds: 1),
    ); // Simulate network/processing delay
    throw UnimplementedError(
      'Azure AI migration in progress. Legacy OCR removed.',
    );
  }
}
