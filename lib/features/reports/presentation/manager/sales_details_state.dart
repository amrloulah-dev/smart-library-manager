part of 'sales_details_cubit.dart';

abstract class SalesDetailsState extends Equatable {
  const SalesDetailsState();

  @override
  List<Object> get props => [];
}

class SalesDetailsInitial extends SalesDetailsState {}

class SalesDetailsLoading extends SalesDetailsState {}

class SalesDetailsLoaded extends SalesDetailsState {
  final double totalDailySales;
  final double cashSales;
  final double creditSales;
  final double
  dailyImprovement; // Percentage vs Previous Period (e.g. Yesterday)
  final List<Sale> recentTransactions;

  const SalesDetailsLoaded({
    required this.totalDailySales,
    required this.cashSales,
    required this.creditSales,
    required this.dailyImprovement,
    required this.recentTransactions,
  });

  @override
  List<Object> get props => [
    totalDailySales,
    cashSales,
    creditSales,
    dailyImprovement,
    recentTransactions,
  ];
}

class SalesDetailsError extends SalesDetailsState {
  final String message;

  const SalesDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
