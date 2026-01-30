part of 'bi_cubit.dart';

abstract class BiState {}

class BiInitial extends BiState {}

class BiLoading extends BiState {}

class BiLoaded extends BiState {
  final List<Book> stockoutPredictions;
  final List<Book> topProfitBooks;
  final List<Supplier> topSuppliers;
  final List<Book> deadStock;
  final String dailyInsight;

  BiLoaded({
    required this.stockoutPredictions,
    required this.topProfitBooks,
    required this.topSuppliers,
    required this.deadStock,
    required this.dailyInsight,
  });
}

class BiError extends BiState {
  final String message;
  BiError(this.message);
}
