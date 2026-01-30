import 'package:equatable/equatable.dart';

class ScannedItemModel extends Equatable {
  final String? code;
  final String name;
  final int quantity;
  final double price;
  final double? sellPrice; // Added for Manual Invoice support
  final bool hasCalculationMismatch;

  const ScannedItemModel({
    this.code,
    required this.name,
    required this.quantity,
    required this.price,
    this.sellPrice,
    this.hasCalculationMismatch = false,
  });
  ScannedItemModel copyWith({
    String? code,
    String? name,
    int? quantity,
    double? price,
    double? sellPrice,
    bool? hasCalculationMismatch,
  }) {
    return ScannedItemModel(
      code: code ?? this.code,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      sellPrice: sellPrice ?? this.sellPrice,
      hasCalculationMismatch:
          hasCalculationMismatch ?? this.hasCalculationMismatch,
    );
  }

  @override
  List<Object?> get props => [
    code,
    name,
    quantity,
    price,
    sellPrice,
    hasCalculationMismatch,
  ];
}
