import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart';

enum InvoiceStatus { complete, partial, unpaid }

class InvoiceWithStatus extends Equatable {
  final PurchaseInvoice invoice;
  final InvoiceStatus status;
  final double paidAmount;

  const InvoiceWithStatus({
    required this.invoice,
    required this.status,
    required this.paidAmount,
  });

  @override
  List<Object> get props => [invoice, status, paidAmount];
}
