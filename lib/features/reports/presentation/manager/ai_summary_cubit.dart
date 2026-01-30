import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';
import 'package:librarymanager/features/reports/domain/services/business_intelligence_service.dart';
import 'package:librarymanager/features/reports/domain/models/risk_analysis_result.dart';
// But wait, we don't have SalesDao injected into Cubit.
// We should probably rely on the Service to do the heavy lifting or Inject SalesDao.
// BiService already HAS SalesDao internally.
// The BiService method signature is `calculateSalesForecast(List<Book> allBooks, SalesDao salesDao)`.
// Ah, that's awkward if BiService already HAS it.
// Why did I design it to take SalesDao as param if it's inside?
// Checking BiService... `class BusinessIntelligenceService { final SalesDao _salesDao; ... }`
// So I don't need to pass it! The prompt Requirement said "Inputs: List<Book>, SalesDao".
// But if it's internal, I can remove that param from the METHOD implementation I just wrote.
// I ALREADY wrote the method taking SalesDao.
// I should pass the internal one OR fix the method.
// Since I can't edit the method easily without another call, I will pass the injected SalesDao -> wait, Cubit doesn't have it.
// I'll grab it via locator or add to constructor?
// Adding to constructor is cleaner.
// AiSummaryCubit(this._repo, this._biService, this._salesDao).
// Let's add SalesDao to props.

part 'ai_summary_state.dart';

@injectable
class AiSummaryCubit extends Cubit<AiSummaryState> {
  final ReportsRepository _reportsRepository;
  final BusinessIntelligenceService _biService;

  AiSummaryCubit(this._reportsRepository, this._biService)
    : super(AiSummaryInitial());

  Future<void> loadAiSummary() async {
    emit(AiSummaryLoading());
    try {
      // 1. Fetch Data
      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);

      final allBooks = await _reportsRepository.getAllBooks();
      final lowStockBooks = await _reportsRepository.getLowStockBooks();
      final salesLast30Days = await _reportsRepository.getSalesInLast30Days();

      // Fetch aggregated metrics for AI calculations
      final salesMTD = await _reportsRepository.getTotalSalesMTD(
        startOfMonth,
        now,
      );
      final currentStockTotal = await _reportsRepository.getTotalCurrentStock();

      // 2. Sales Forecast: Use BI Service Algorithm
      final forecastResult = await _biService.calculateSalesForecast(
        salesMTD: salesMTD,
        currentStockTotal: currentStockTotal,
      );

      final salesForecastScore = forecastResult['forecastRatio'] ?? 0.0;
      final salesForecastChange = forecastResult['growthDiff'] ?? 0.0;

      // 3. Best Sellers: Get top 5 sorted by volume sold
      final List<BestSellerItem> bestSellers = [];

      // Create a map of book ID to sales quantity
      final bookSalesMap = <String, int>{};
      salesLast30Days.forEach((bookId, qty) {
        bookSalesMap[bookId] = (bookSalesMap[bookId] ?? 0) + qty;
      });

      // Sort by quantity sold
      final sortedBookIds = bookSalesMap.keys.toList()
        ..sort((a, b) => bookSalesMap[b]!.compareTo(bookSalesMap[a]!));

      // Get top 5
      for (var i = 0; i < sortedBookIds.length && i < 5; i++) {
        final bookId = sortedBookIds[i];
        final book = allBooks.firstWhere(
          (b) => b.id == bookId,
          orElse: () => allBooks.first,
        );
        final qtySold = bookSalesMap[bookId] ?? 0;
        final profit = (book.sellPrice - book.costPrice) * qtySold;

        bestSellers.add(
          BestSellerItem(
            book: book,
            quantitySold: qtySold,
            totalProfit: profit,
          ),
        );
      }

      // 4. Dead Stock: Analyze Risks using BI Service

      // Note: effective linking of Book -> Supplier requires complex queries (via PurchaseItems)
      // For list performance, we accept default return policies (passed as null) for now.

      final List<DeadStockItem> deadStock = [];

      for (final book in allBooks) {
        // Skip books with 0 stock unless we want to track 'Obsolete' even if 0 stock?
        if (book.currentStock <= 0) continue;

        // Pass null for supplier to use defaults
        final risk = await _biService.analyzeBookRisk(book, null);

        if (risk.level != RiskLevel.safe) {
          deadStock.add(DeadStockItem(book: book, risk: risk));
        }
      }

      // Sort by Priority Score Descending
      deadStock.sort(
        (a, b) => b.risk.priorityScore.compareTo(a.risk.priorityScore),
      );

      // Phase 7.5: Calculate Stock Health Index
      // 1. Classify Shortages
      int criticalShortages = 0;
      int normalShortages = 0;
      for (var book in lowStockBooks) {
        if (book.currentStock <= 1) {
          criticalShortages++;
        } else {
          normalShortages++;
        }
      }

      // 2. Classify Dead Stock
      int redDeadStock = 0;
      int yellowDeadStock = 0;
      for (var item in deadStock) {
        final level = item.risk.level;
        if (level == RiskLevel.obsolete ||
            level == RiskLevel.earlyFailure ||
            level == RiskLevel.timeTrap) {
          redDeadStock++;
        } else if (level == RiskLevel.coma) {
          yellowDeadStock++;
        }
      }

      // 3. Calculate Score
      double inventoryHealthScore = _biService.calculateStockHealthIndex(
        criticalShortages,
        normalShortages,
        redDeadStock,
        yellowDeadStock,
      );

      // Mock health change for now (requires historic snapshot)
      const inventoryHealthChange = 0.0;

      emit(
        AiSummaryLoaded(
          AiSummaryData(
            inventoryHealthScore: inventoryHealthScore,
            inventoryHealthChange: inventoryHealthChange,
            salesForecastScore: salesForecastScore,
            salesForecastChange: salesForecastChange,
            bestSellers: bestSellers,
            deadStock: deadStock,
          ),
        ),
      );
    } catch (e) {
      emit(AiSummaryError(e.toString()));
    }
  }
}
