import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';
import 'package:librarymanager/features/reports/domain/services/business_intelligence_service.dart';

part 'bi_state.dart';

@injectable
class BiCubit extends Cubit<BiState> {
  final ReportsRepository _reportsRepository;
  final BusinessIntelligenceService _biService;

  BiCubit(this._reportsRepository, this._biService) : super(BiInitial());

  Future<void> loadBiData() async {
    emit(BiLoading());
    try {
      // 1. Fetch Data in Parallel where possible, but await logic is simple here
      final allBooks = await _reportsRepository.getAllBooks();
      final salesLast30 = await _reportsRepository.getSalesInLast30Days();
      final topProfit = await _reportsRepository.getTopProfitBooks();
      final topSuppliers = await _reportsRepository.getTopSuppliers();
      final deadStock = await _reportsRepository.getDeadStockBooks();

      // 2. Logic: Stockout Predictions
      final stockoutPredictions = <Book>[];
      for (final book in allBooks) {
        final soldQty = salesLast30[book.id] ?? 0;
        final velocity = _biService.calculateSalesVelocity(soldQty, 30);
        final stockoutDate = _biService.predictStockoutDate(
          book.currentStock,
          velocity,
        );

        if (stockoutDate != null) {
          final daysUntil = stockoutDate.difference(DateTime.now()).inDays;
          // Prediction: Run out in < 7 days
          if (daysUntil < 7 && daysUntil >= 0) {
            stockoutPredictions.add(book);
          }
        }
      }

      // 3. Generate Insight
      String insight = 'Everything looks steady.';
      if (stockoutPredictions.isNotEmpty) {
        insight =
            'Attention: ${stockoutPredictions.length} items are predicted to run out this week based on recent sales velocity.';
      } else if (topProfit.isNotEmpty && topProfit.first.totalSoldQty > 10) {
        insight =
            "Great Job! '${topProfit.first.name}' is your top profit generator this period.";
      } else if (deadStock.isNotEmpty) {
        insight =
            'Optimization Tip: Consider a clearance sale for ${deadStock.length} stagnant items.';
      }

      emit(
        BiLoaded(
          stockoutPredictions: stockoutPredictions,
          topProfitBooks: topProfit,
          topSuppliers: topSuppliers,
          deadStock: deadStock,
          dailyInsight: insight,
        ),
      );
    } catch (e) {
      emit(BiError(e.toString()));
    }
  }
}
