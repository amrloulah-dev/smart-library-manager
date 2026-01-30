import 'package:equatable/equatable.dart';

class SupplierStats extends Equatable {
  final double totalDebt;
  final double totalPaid;
  final int invoiceCount;
  final double returnRate;
  final List<double> weeklyActivity;

  final String aiInsight;

  const SupplierStats({
    required this.totalDebt,
    required this.totalPaid,
    required this.invoiceCount,
    required this.returnRate,
    required this.weeklyActivity,
    required this.aiInsight,
  });

  @override
  List<Object> get props => [
    totalDebt,
    totalPaid,
    invoiceCount,
    returnRate,
    weeklyActivity,
    aiInsight,
  ];
}
