import 'package:equatable/equatable.dart';

class ScannedInvoiceItem extends Equatable {
  final String bookName;
  final int quantity;
  final double costPrice;
  final double sellingPrice;
  final bool hasCalculationMismatch;

  // Optional: keeping the original azure total for reference if needed,
  // though strictly not in the requested list, it's good practice.
  // I will follow strict list from prompt for the required fields.

  const ScannedInvoiceItem({
    this.bookName = '',
    this.quantity = 0,
    this.costPrice = 0.0,
    this.sellingPrice = 0.0,
    this.hasCalculationMismatch = false,
  });

  ScannedInvoiceItem copyWith({
    String? bookName,
    int? quantity,
    double? costPrice,
    double? sellingPrice,
    bool? hasCalculationMismatch,
  }) {
    return ScannedInvoiceItem(
      bookName: bookName ?? this.bookName,
      quantity: quantity ?? this.quantity,
      costPrice: costPrice ?? this.costPrice,
      sellingPrice: sellingPrice ?? this.sellingPrice,
      hasCalculationMismatch:
          hasCalculationMismatch ?? this.hasCalculationMismatch,
    );
  }

  @override
  List<Object?> get props => [
    bookName,
    quantity,
    costPrice,
    sellingPrice,
    hasCalculationMismatch,
  ];
}
