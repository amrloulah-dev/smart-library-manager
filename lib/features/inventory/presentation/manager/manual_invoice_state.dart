import 'package:equatable/equatable.dart';
import 'package:librarymanager/core/database/app_database.dart';

// Simple model for manual items
class ManualInvoiceItem extends Equatable {
  final String bookName;
  final int quantity;
  final double costPrice;
  final double sellPrice;

  // Optional: other fields like publisher, subject etc if needed for "create book" logic
  // but usually we just need the composite name for creation/lookup.

  final String? bookId;

  const ManualInvoiceItem({
    required this.bookName,
    required this.quantity,
    required this.costPrice,
    required this.sellPrice,
    this.bookId,
  });

  double get totalCost => quantity * costPrice;

  @override
  List<Object?> get props => [bookName, quantity, costPrice, sellPrice, bookId];
}

class ManualInvoiceState extends Equatable {
  // Master
  final Supplier? selectedSupplier;
  final DateTime? invoiceDate;

  // Detail
  final List<ManualInvoiceItem> items;
  final double paidAmount; // Paid amount during invoice creation
  final double discountPercent;

  // Status
  final bool isSubmitting;
  final String? error;
  final String? successMessage;

  const ManualInvoiceState({
    this.selectedSupplier,
    this.invoiceDate,
    this.items = const [],
    this.paidAmount = 0.0,
    this.discountPercent = 0.0,
    this.isSubmitting = false,
    this.error,
    this.successMessage,
  });

  ManualInvoiceState copyWith({
    Supplier? selectedSupplier,
    DateTime? invoiceDate,
    List<ManualInvoiceItem>? items,
    double? paidAmount,
    double? discountPercent,
    bool? isSubmitting,
    String? error,
    String? successMessage,
  }) {
    return ManualInvoiceState(
      selectedSupplier: selectedSupplier ?? this.selectedSupplier,
      invoiceDate: invoiceDate ?? this.invoiceDate,
      items: items ?? this.items,
      paidAmount: paidAmount ?? this.paidAmount,
      discountPercent: discountPercent ?? this.discountPercent,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error, // Nullable reset
      successMessage: successMessage, // Nullable reset
    );
  }

  double get totalCost => items.fold(0, (sum, item) => sum + item.totalCost);

  @override
  List<Object?> get props => [
    selectedSupplier,
    invoiceDate,
    items,
    paidAmount,
    discountPercent,
    isSubmitting,
    error,
    successMessage,
  ];
}
