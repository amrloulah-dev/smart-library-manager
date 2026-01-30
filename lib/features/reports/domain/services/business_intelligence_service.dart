import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/database/daos/sales_dao.dart';
import 'package:librarymanager/core/database/daos/smart_settings_dao.dart';
import 'package:librarymanager/core/database/daos/books_dao.dart';
import 'package:librarymanager/features/reports/domain/models/risk_analysis_result.dart';
import 'dart:math';

enum AlertLevel { none, safe, warning, critical, expired }

class RestockSuggestion {
  final int suggestedOrder;
  final String reasoning;
  final double confidence; // Not explicitly used but good for future ranking

  RestockSuggestion({
    required this.suggestedOrder,
    required this.reasoning,
    this.confidence = 1.0,
  });
}

@lazySingleton
class BusinessIntelligenceService {
  final SalesDao _salesDao;
  final SmartSettingsDao _smartSettingsDao;
  final BooksDao _booksDao;

  BusinessIntelligenceService(
    this._salesDao,
    this._smartSettingsDao,
    this._booksDao,
  );

  /// Method 1: calculateSalesVelocity
  /// Input: int quantitySold, int periodInDays.
  /// Logic: quantitySold / periodInDays.
  /// Returns: double (Items sold per day).
  double calculateSalesVelocity(int quantitySold, int periodInDays) {
    if (periodInDays <= 0) return 0.0;
    return quantitySold / periodInDays;
  }

  /// Method 2: predictStockoutDate
  /// Input: int currentStock, double dailyVelocity.
  /// Logic:
  /// - If velocity <= 0, return null (Won't run out).
  /// - daysLeft = currentStock / dailyVelocity.
  /// - Return DateTime.now().add(Duration(days: daysLeft)).
  DateTime? predictStockoutDate(int currentStock, double dailyVelocity) {
    if (dailyVelocity <= 0) return null;
    final daysLeft = currentStock / dailyVelocity;
    // Rounding down or up? "daysLeft" usually implies integer days for Duration, but double calculation is more precise.
    // Duration takes int days, hours etc.
    // Let's us multiply by 24 hours to be precise if needed, or just round.
    // Logic: 50 stock / 5 per day = 10 days.
    // 50 stock / 5.5 per day = 9.09 days.
    return DateTime.now().add(
      Duration(milliseconds: (daysLeft * 24 * 60 * 60 * 1000).toInt()),
    );
  }

  /// Method 3: getReturnAlertLevel (For Returns Alarm)
  /// Input: DateTime? returnDeadline.
  /// Logic:
  /// - If deadline is null, return AlertLevel.none.
  /// - If deadline is passed (< now), return AlertLevel.expired (Red).
  /// - If deadline is within 14 days, return AlertLevel.critical (Red).
  /// - If deadline is within 30 days, return AlertLevel.warning (Yellow).
  /// - Else, AlertLevel.safe (Green).
  AlertLevel getReturnAlertLevel(DateTime? returnDeadline) {
    if (returnDeadline == null) return AlertLevel.none;

    final now = DateTime.now();
    if (returnDeadline.isBefore(now)) return AlertLevel.expired;

    final difference = returnDeadline.difference(now).inDays;

    if (difference <= 14) return AlertLevel.critical;
    if (difference <= 30) return AlertLevel.warning;

    return AlertLevel.safe;
  }

  /// Method 4: calculateSupplierScore
  /// Input: int totalItemsPurchased, int totalItemsReturned.
  /// Logic:
  /// - returnRate = totalItemsReturned / totalItemsPurchased.
  /// - Base Score = 5.0.
  /// - Penalty = returnRate * 5. (e.g., 20% returns = 1 star penalty).
  /// - finalScore = 5.0 - Penalty.
  /// - Clamp between 1.0 and 5.0.
  double calculateSupplierScore(
    int totalItemsPurchased,
    int totalItemsReturned,
  ) {
    if (totalItemsPurchased <= 0) return 5.0; // Default if no purchases

    final returnRate = totalItemsReturned / totalItemsPurchased;
    final penalty = returnRate * 5.0;
    final finalScore = 5.0 - penalty;

    if (finalScore < 1.0) return 1.0;
    if (finalScore > 5.0) return 5.0;
    return finalScore;
  }

  /// Phase 7.5: Sales Forecast (Predictive Sell-Through)
  /// Returns { 'forecastRatio': double, 'growthDiff': double }
  Future<Map<String, double>> calculateSalesForecast({
    required double salesMTD,
    required int currentStockTotal,
  }) async {
    final now = DateTime.now();
    final daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final daysPassed = now.day;

    double projectedFutureSales = 0.0;
    if (daysPassed > 0) {
      projectedFutureSales =
          (salesMTD / daysPassed) * (daysInMonth - daysPassed);
    }

    double totalProjectedOut = salesMTD + projectedFutureSales;
    double totalInventoryPool = salesMTD + currentStockTotal;

    if (totalInventoryPool <= 0) {
      return {'forecastRatio': 0.0, 'growthDiff': 0.0};
    }

    double forecastRatio = (totalProjectedOut / totalInventoryPool) * 100.0;
    forecastRatio = forecastRatio.clamp(0.0, 100.0);

    return {'forecastRatio': forecastRatio, 'growthDiff': 0.0};
  }

  /// Phase 7.3: Generate Restock Suggestion
  Future<RestockSuggestion> generateRestockSuggestion(Book book) async {
    // 1. Gather Data
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));
    final salesHistory = await _salesDao.getDailySalesForBook(
      book.id,
      thirtyDaysAgo,
    );
    final seasonEnd = await _smartSettingsDao.getSeasonEndDate();
    int? targetAudience;
    if (book.grade != null) {
      targetAudience = await _smartSettingsDao.getTargetForGrade(book.grade!);
    }

    // Note: IncomingOrders should ideally be fetched from PurchaseInvoices matching 'ordered' status.
    // For now assuming 0 if not easily available without new DAO queries.
    // Or we could implement a quick check in main repo if needed.
    // Let's assume 0 for MVP to stick to provided constraints unless critical.
    const incomingOrders = 0;

    // 2. Calculate Factors

    // 2.1 Velocity (V) - Last 7 Days
    double velocity = 0.0;
    int soldLast7Days = 0;
    int daysConsidered = 7;
    for (int i = 0; i < 7; i++) {
      final date = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));
      soldLast7Days += salesHistory[date] ?? 0;
    }
    velocity = soldLast7Days / daysConsidered;

    // 2.2 Trend Factor (T)
    // Short: Last 3 days
    double shortAvg = 0.0;
    int soldLast3Days = 0;
    for (int i = 0; i < 3; i++) {
      // Note: Using 'i' here maps to today, yesterday...
      // Ideally exclude today if it's partial, but simplify: use last 3 full days?
      // Let's stick to simple "Last X days" relative to now.
      final date = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));
      soldLast3Days += salesHistory[date] ?? 0;
    }
    shortAvg = soldLast3Days / 3;

    // Long: Last 10 days
    double longAvg = 0.0;
    int soldLast10Days = 0;
    for (int i = 0; i < 10; i++) {
      final date = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(Duration(days: i));
      soldLast10Days += salesHistory[date] ?? 0;
    }
    longAvg = soldLast10Days / 10;

    double trendFactor = 1.0;
    String trendReason = '';
    if (shortAvg > longAvg * 1.2) {
      trendFactor = 1.2;
      trendReason = 'Trending Up (+20%)';
    } else if (shortAvg < longAvg * 0.8) {
      trendFactor = 0.8;
      trendReason = 'Sales Slowing Down';
    }

    // 2.3 Season Factor (S)
    double seasonFactor = 1.0;
    String seasonReason = '';
    if (seasonEnd != null) {
      final daysToSeasonEnd = seasonEnd.difference(now).inDays;
      if (daysToSeasonEnd > 60) {
        seasonFactor = 1.0;
      } else if (daysToSeasonEnd < 14) {
        seasonFactor = 0.1;
        seasonReason = 'End of Season Imminent (Stop Ordering)';
      } else {
        // Linear Decay
        seasonFactor = daysToSeasonEnd / 60;
        seasonReason = 'Season Ending soon (reducing orders)';
      }
    }

    // 2.4 Market Cap (M)
    int remainingPotential = 999999; // Infinite default
    String marketReason = '';
    if (targetAudience != null && targetAudience > 0) {
      remainingPotential = targetAudience - book.totalSoldQty;
      if (remainingPotential < 0) remainingPotential = 0;

      // If we are close to saturation
      if (remainingPotential < 50) {
        // Arbitrary small number
        marketReason = 'Market nearly saturated';
      }
    }

    // 3. The Formula
    // BaseNeed = Velocity * (LeadTime + Buffer)
    // LeadTime = 3, Buffer = 2 => 5
    // Better: Fetch LeadTime from AppSettings if possible, default 3.
    // We didn't fetch settings for lead time, assume 3 (default) + 2 buffer.
    const leadTime = 3;
    const buffer = 2;
    double baseNeed = velocity * (leadTime + buffer);

    double grossNeed = baseNeed * trendFactor * seasonFactor;

    // CappedNeed = Min(GrossNeed, RemainingPotential)
    double cappedNeed = min(grossNeed, remainingPotential.toDouble());

    // NetSuggestion = CappedNeed - (CurrentStock + IncomingOrders)
    double netSuggestion = cappedNeed - (book.currentStock + incomingOrders);

    // 4. Formatting Result
    int finalQty = netSuggestion.ceil();
    if (finalQty < 0) finalQty = 0;

    // Build comprehensive reason
    List<String> reasons = [];
    if (finalQty > 0) {
      if (velocity > 0) {
        reasons.add('Velocity: ${velocity.toStringAsFixed(1)}/day');
      }
      if (trendReason.isNotEmpty) reasons.add(trendReason);
      if (seasonReason.isNotEmpty) reasons.add(seasonReason);
      if (marketReason.isNotEmpty) reasons.add(marketReason);
      if (reasons.isEmpty) reasons.add('Normal Replenishment');
    } else {
      if (seasonFactor < 0.5 && seasonReason.isNotEmpty) {
        reasons.add(seasonReason);
      } else if (book.currentStock >= cappedNeed) {
        reasons.add('Sufficient Stock');
      } else {
        reasons.add('No need');
      }
    }

    return RestockSuggestion(
      suggestedOrder: finalQty,
      reasoning: reasons.join(', '),
    );
  }
  // ... (existing code up to generateRestockSuggestion)

  /// Phase 7.2: Dead Stock Liquidation Algorithm
  Future<RiskAnalysisResult> analyzeBookRisk(
    Book book,
    Supplier? supplier,
  ) async {
    // 1. Calculations & Setup
    final now = DateTime.now();
    final currentYear = now.year;

    // Days Owned (since last supply or default to createdAt/now if missing)
    // If no supply date, maybe check created date?
    // Book doesn't expose createdAt easily in main table? It does not.
    // We'll trust lastSupplyDate. If null, we might assume it's new or unknown.
    // If null, we'll look at TotalSold. If TotalSold > 0, we can guess it's been around.
    // However, for strict algorithm, if lastSupplyDate is null, we might treat as "Unknown Duration".
    // Let's default to specific logic:
    // If lastSupplyDate is null, we skip "Early Failure" logic based on days.
    final lastSupply = book.lastSupplyDate;
    final int daysOwned = lastSupply != null
        ? now.difference(lastSupply).inDays
        : 0;

    // 1. GRACE PERIOD CHECK
    if (daysOwned < 10) {
      return RiskAnalysisResult.safe().copyWith(
        message: 'بضاعة جديدة (فترة سماح)',
      );
    }

    // Return Info
    final bool isReturnable =
        supplier?.isReturnable ?? true; // Default to true per biz rule
    final int returnPolicyDays = supplier?.returnPolicyDays ?? 90;

    // Days Left to Return
    // If daysOwned is 0 (and valid supply date exists), daysLeft is full policy.
    final int daysLeft = returnPolicyDays - daysOwned;

    // Days Since Last Sale
    final lastSale = book.lastSaleDate;
    final int daysSinceSale = lastSale != null
        ? now.difference(lastSale).inDays
        : 999;
    // 999 if never sold (treated as infinite stagnation)

    // Filter 1: Obsolescence (Black Alert ⚫)
    // Check edition year. If existing edition < currentYear - 1?
    // Or just simple: if editionYear != null AND editionYear < currentYear
    // "Is book.editionYear < Current Year?" -> Strict?
    // Usually older editions are okay if next year hasn't started, but prompt says "< Current Year".
    // So if 2024, and book is 2023 -> Obsolete.
    if (book.editionYear != null && book.editionYear! < currentYear) {
      return const RiskAnalysisResult(
        level: RiskLevel.obsolete,
        message: 'طبعة قديمة',
        action: 'إعدام مخزون/بيع حرق',
        priorityScore: 100.0,
      );
    }

    // Filter 2: Early Failure (Red Alert 🔴)
    // Check: If daysOwned between 20 and 45.
    if (daysOwned >= 20 && daysOwned <= 45) {
      // Calc sellThrough
      // Note: totalPurchased is not stored directly on Book.
      // We can approximate: totalPurchased = currentStock + totalSoldQty.
      // (Ignoring returns/adjustments for MVP speed).
      final totalPurchased = book.currentStock + book.totalSoldQty;

      if (totalPurchased > 0) {
        final sellThrough = book.totalSoldQty / totalPurchased;
        if (sellThrough < 0.10) {
          // Less than 10% sold
          return RiskAnalysisResult(
            level: RiskLevel.earlyFailure,
            message:
                'فشل في الانطلاق (${(sellThrough * 100).toStringAsFixed(1)}%)',
            action: 'إرجاع مبكر',
            priorityScore: 90.0,
          );
        }
      }
    }

    // Filter 3: Time Trap (Red Alert 🔴) - The Smartest
    if (isReturnable && daysLeft > 0) {
      // Calc Velocity (Sales/Day)
      // We need a velocity metric.
      // Use local helper `calculateSalesVelocity`.
      // We need quantity sold over a period.
      // Ideally "Period" is `daysOwned`.
      // If daysOwned is small, velocity might be volatile.
      // If daysOwned is 0, velocity is infinite/undefined.
      int effectiveDays = daysOwned > 0 ? daysOwned : 1;
      final velocity = calculateSalesVelocity(book.totalSoldQty, effectiveDays);

      // Conservative Rate (90% of current speed)
      final conservativeRate = velocity * 0.9;

      // Max Capacity (How many we can sell before deadline)
      final maxCapacity = conservativeRate * daysLeft;

      // Excess Stock
      final excessStock = book.currentStock - maxCapacity;

      if (excessStock > 5) {
        // Score Calculation:
        // Urgency: (90 - daysLeft) / 90 -> Closer to 0 days left = Higher score.
        // Value: excessStock * costPrice.
        // Let's normalize score to 0-100.

        double urgencyScore = 0;
        if (returnPolicyDays > 0) {
          urgencyScore =
              ((returnPolicyDays - daysLeft) / returnPolicyDays) * 50;
          // 50 points max for urgency
        }

        // Value Score: arbitrary scaling. Say Max expected value is 5000 EGP = 50 pts.
        double valueParams =
            (excessStock * book.costPrice) / 100; // 100 EGP = 1 pt
        if (valueParams > 50) valueParams = 50;

        final score = urgencyScore + valueParams;

        return RiskAnalysisResult(
          level: RiskLevel.timeTrap,
          message: 'لن يباع قبل المهلة (متبقي $daysLeft يوم)',
          action: 'إرجاع الفائض',
          suggestedReturnQty: excessStock.ceil(),
          priorityScore: score,
        );
      }
    }

    // Filter 4: Coma (Yellow Alert 🟡)
    // If daysLeft <= 0 OR !isReturnable
    if (daysLeft <= 0 || !isReturnable) {
      // Condition: daysSinceSale > 30
      if (daysSinceSale > 30) {
        // If stock is 0, it's not a comma, it's out of stock.
        // Assuming we only analyze books with stock > 0?
        // This check usually implies we have stock.
        if (book.currentStock > 0) {
          return const RiskAnalysisResult(
            level: RiskLevel.coma,
            message: 'ركود تام (>30 يوم بدون بيع)',
            action: 'عرض ترويجي',
            priorityScore: 50.0,
          );
        }
      }
    }

    // Default
    return RiskAnalysisResult.safe();
  }

  /// Phase 7.5: Stock Health Index
  /// Inputs: Critical Shortages, Normal Shortages, Red Dead Stock, Yellow Dead Stock
  double calculateStockHealthIndex(
    int criticalShortages, // Urgent restock needed
    int normalShortages, // Low stock, not critical
    int redDeadStock, // Time Trap / Early Failure
    int yellowDeadStock, // Coma / Obsolete
  ) {
    double initialScore = 100.0;

    // Penalty Calculation
    // Critical Shortages are very bad (-5 pts each), capped at 40
    double shortagePenalty =
        (criticalShortages * 5.0) + (normalShortages * 2.0);
    shortagePenalty = shortagePenalty.clamp(0.0, 40.0); // Capped at 40

    // Dead Stock Penalty
    // Red cases are worse (-4 pts each), capped at 40
    double deadStockPenalty = (redDeadStock * 4.0) + (yellowDeadStock * 1.0);
    deadStockPenalty = deadStockPenalty.clamp(0.0, 40.0); // Capped at 40

    // Final Calculation with clamping 0-100
    double finalScore = initialScore - shortagePenalty - deadStockPenalty;
    finalScore = finalScore.clamp(0.0, 100.0);

    return finalScore;
  }

  /// Check if a book is a shortage based on AI analysis (Sales Logic)
  /// Uses "Velocity" approximation based on total history to be synchronous.
  bool isShortage(Book book) {
    // 1. Critical: Out of Stock
    if (book.currentStock <= 0) return true;

    // 2. Determine Velocity
    // If we can't query detailed history synchronously, we use averages.
    final daysOwned = book.lastSupplyDate != null
        ? DateTime.now().difference(book.lastSupplyDate!).inDays
        : 0;

    // Safety for very new items (guard against division by zero or infinite velocity)
    if (daysOwned <= 0 && book.totalSoldQty == 0) return false;

    final effectiveDays = daysOwned < 1 ? 1 : daysOwned;
    final velocity = book.totalSoldQty / effectiveDays;

    // If selling nothing, no shortage
    if (velocity <= 0) return false;

    // 3. Predict Depletion
    final daysUntilDepletion = book.currentStock / velocity;

    // 4. Threshold
    // If stock will last less than 7 days (Lead Time ~3 + Buffer ~4)
    return daysUntilDepletion < 7.0;
  }
}
