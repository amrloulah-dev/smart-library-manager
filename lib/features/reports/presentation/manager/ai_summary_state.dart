part of 'ai_summary_cubit.dart';

/// Model for Best Seller Item
class BestSellerItem {
  final Book book;
  final int quantitySold;
  final double totalProfit;

  const BestSellerItem({
    required this.book,
    required this.quantitySold,
    required this.totalProfit,
  });
}

/// Model for Dead Stock Item
/// Model for Dead Stock Item
class DeadStockItem {
  final Book book;
  final RiskAnalysisResult risk;

  const DeadStockItem({required this.book, required this.risk});
}

/// AI Summary Data Model
class AiSummaryData {
  final double inventoryHealthScore;
  final double inventoryHealthChange;
  final double salesForecastScore;
  final double salesForecastChange;
  final List<BestSellerItem> bestSellers;
  final List<DeadStockItem> deadStock;

  const AiSummaryData({
    required this.inventoryHealthScore,
    required this.inventoryHealthChange,
    required this.salesForecastScore,
    required this.salesForecastChange,
    required this.bestSellers,
    required this.deadStock,
  });
}

/// States
abstract class AiSummaryState extends Equatable {
  const AiSummaryState();

  @override
  List<Object> get props => [];
}

class AiSummaryInitial extends AiSummaryState {}

class AiSummaryLoading extends AiSummaryState {}

class AiSummaryLoaded extends AiSummaryState {
  final AiSummaryData data;

  const AiSummaryLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class AiSummaryError extends AiSummaryState {
  final String message;

  const AiSummaryError(this.message);

  @override
  List<Object> get props => [message];
}
