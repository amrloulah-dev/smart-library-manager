import 'dart:io';
import '../models/scanned_item_model.dart';

abstract class InvoiceRepository {
  Future<List<ScannedItemModel>> scanInvoiceImage(File image);
}
