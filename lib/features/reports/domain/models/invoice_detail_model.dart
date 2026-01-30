import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart';

class PurchaseItemWithBook extends Equatable {
  final PurchaseItem item;
  final String bookName;

  const PurchaseItemWithBook({required this.item, required this.bookName});

  @override
  List<Object> get props => [item, bookName];
}

class InvoiceDetailModel extends Equatable {
  final PurchaseInvoice invoice;
  final Supplier supplier;
  final List<PurchaseItemWithBook> items;

  const InvoiceDetailModel({
    required this.invoice,
    required this.supplier,
    required this.items,
  });

  @override
  List<Object> get props => [invoice, supplier, items];
}
