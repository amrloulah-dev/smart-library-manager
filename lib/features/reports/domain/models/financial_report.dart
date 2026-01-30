import 'package:equatable/equatable.dart';

class DailySalesPoint extends Equatable {
  final DateTime day;
  final double totalSales;

  const DailySalesPoint({required this.day, required this.totalSales});

  @override
  List<Object> get props => [day, totalSales];
}

class TopProfitableItem extends Equatable {
  final int rank;
  final String name;
  final double profit;
  final double performance; // 0.0 to 1.0

  const TopProfitableItem({
    required this.rank,
    required this.name,
    required this.profit,
    required this.performance,
  });

  @override
  List<Object> get props => [rank, name, profit, performance];
}

class FinancialReport extends Equatable {
  final double totalRevenue;
  final double totalSalesCash;
  final double totalSalesCredit;
  final double totalCOGS; // Cost of Goods Sold
  final double totalExpenses;
  final double netProfit;
  final List<TopProfitableItem> topProfitableItems;

  const FinancialReport({
    this.totalRevenue = 0.0,
    this.totalSalesCash = 0.0,
    this.totalSalesCredit = 0.0,
    this.totalCOGS = 0.0,
    this.totalExpenses = 0.0,
    this.netProfit = 0.0,
    this.topProfitableItems = const [],
  });

  @override
  List<Object> get props => [
    totalRevenue,
    totalSalesCash,
    totalSalesCredit,
    totalCOGS,
    totalExpenses,
    netProfit,
    topProfitableItems,
  ];
}
