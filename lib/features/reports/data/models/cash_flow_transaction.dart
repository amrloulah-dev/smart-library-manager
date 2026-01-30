import 'package:equatable/equatable.dart';

enum TransactionType { income, expense }

class CashFlowTransaction extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category; // 'sale', 'expense', 'purchase'

  const CashFlowTransaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    subtitle,
    amount,
    date,
    type,
    category,
  ];
}
