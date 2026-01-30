import 'dart:async';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/database/daos/books_dao.dart';
import 'package:librarymanager/core/database/daos/suppliers_dao.dart';
import 'package:librarymanager/core/database/daos/sales_dao.dart';
import 'package:librarymanager/core/database/daos/expenses_dao.dart';
import 'package:librarymanager/core/utils/math_utils.dart';
import 'package:librarymanager/features/reports/domain/models/supplier_stats.dart';
import 'package:librarymanager/features/reports/domain/models/invoice_detail_model.dart';
import 'package:librarymanager/features/reports/domain/repositories/reports_repository.dart';
import 'package:librarymanager/features/reports/domain/models/financial_report.dart';

@LazySingleton(as: ReportsRepository)
class ReportsRepositoryImpl implements ReportsRepository {
  final SalesDao _salesDao;
  final BooksDao _booksDao;
  final SuppliersDao _suppliersDao;
  final ExpensesDao _expensesDao;
  final AppDatabase _db;

  ReportsRepositoryImpl(
    this._salesDao,
    this._booksDao,
    this._suppliersDao,
    this._expensesDao,
    this._db,
  );

  @override
  Future<DashboardStats> getDashboardStats() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

      // 1. Sales Summary (Total & Profit)
      final totalSales = await _salesDao.getSalesTotalForDateRange(
        startOfDay,
        endOfDay,
      );

      // Profit Calculation (Separate query as DAO currently only returns Total Amount)
      final profitQuery = _db.selectOnly(_db.sales)
        ..addColumns([_db.sales.totalProfit.sum()])
        ..where(
          _db.sales.saleDate.isBetween(
            Variable(startOfDay),
            Variable(endOfDay),
          ),
        );
      final profitResult = await profitQuery.getSingleOrNull();
      final totalProfit =
          profitResult?.read(_db.sales.totalProfit.sum()) ?? 0.0;

      // 2. Expenses Summary
      final totalExpenses = await _expensesDao.getExpensesTotalForDateRange(
        startOfDay,
        endOfDay,
      );

      // 3. Net Profit Calculation
      final netProfit = totalProfit - totalExpenses;

      // 4. Counts (Low Stock, Returns)
      int lowStockCount = 0;
      int returnsCount = 0;

      try {
        // Shortage Count (Strictly Out of Stock as per user definition)
        final shortageQuery = _db.selectOnly(_db.books)
          ..addColumns([_db.books.id.count()])
          ..where(_db.books.currentStock.equals(0));

        final shortageResult = await shortageQuery.getSingleOrNull();
        lowStockCount = shortageResult?.read(_db.books.id.count()) ?? 0;

        // Returns Count (Supplier Returns)
        final returnsQuery = _db.selectOnly(_db.returnInvoices)
          ..addColumns([_db.returnInvoices.id.count()])
          ..where(
            _db.returnInvoices.returnDate.isBetween(
              Variable(startOfDay),
              Variable(endOfDay),
            ),
          );

        final returnsResult = await returnsQuery.getSingleOrNull();
        returnsCount = returnsResult?.read(_db.returnInvoices.id.count()) ?? 0;
      } catch (e) {}

      // 5. Cash In Drawer (Actual Cash Flow Calculation)
      // Query 1: Sum of paidAmount from Sales (actual cash received)
      final paidAmountQuery = _db.selectOnly(_db.sales)
        ..addColumns([_db.sales.paidAmount.sum()])
        ..where(
          _db.sales.saleDate.isBetween(
            Variable(startOfDay),
            Variable(endOfDay),
          ),
        );
      final paidAmountResult = await paidAmountQuery.getSingleOrNull();
      final totalPaidAmount =
          paidAmountResult?.read(_db.sales.paidAmount.sum()) ?? 0.0;

      // Query 2: Sum of refundAmount from SalesReturns (cash out)
      final refundsQuery = _db.selectOnly(_db.salesReturns)
        ..addColumns([_db.salesReturns.refundAmount.sum()])
        ..where(
          _db.salesReturns.returnDate.isBetween(
            Variable(startOfDay),
            Variable(endOfDay),
          ),
        );
      final refundsResult = await refundsQuery.getSingleOrNull();
      final totalRefunds = MathUtils.round(
        refundsResult?.read(_db.salesReturns.refundAmount.sum()) ?? 0.0,
      );

      // Final Calculation: Income = totalSales, Expense = totalExpenses
      // This is synchronized with CashFlowScreen logic (Total Income - Total Expenses)
      final cashIn = MathUtils.round(totalSales);
      final cashOut = MathUtils.round(totalExpenses);
      final cashInDrawer = MathUtils.round(cashIn - cashOut);

      // 6. Recent Sales
      final recentSales = await _salesDao.getRecentSales(5);

      // 7. Books Sold Today
      int booksSoldToday = 0;
      try {
        final soldQtyQuery =
            _db.selectOnly(_db.saleItems).join([
                innerJoin(
                  _db.sales,
                  _db.sales.id.equalsExp(_db.saleItems.saleId),
                ),
              ])
              ..where(
                _db.sales.saleDate.isBetween(
                  Variable(startOfDay),
                  Variable(endOfDay),
                ),
              )
              ..addColumns([_db.saleItems.quantity.sum()]);

        final soldQtyResult = await soldQtyQuery.getSingleOrNull();
        booksSoldToday = soldQtyResult?.read(_db.saleItems.quantity.sum()) ?? 0;
      } catch (e) {
        if (kDebugMode) print('Error calculating books sold today: $e');
      }

      // 8. MoM Sales Growth for AI Insight
      final firstDayCurrentMonth = DateTime(now.year, now.month, 1);
      final firstDayLastMonth = DateTime(now.year, now.month - 1, 1);
      final lastDayLastMonth = DateTime(now.year, now.month, 0, 23, 59, 59);

      final currentMonthSales = await getTotalSalesMTD(
        firstDayCurrentMonth,
        now,
      );
      final lastMonthSales = await getTotalSalesMTD(
        firstDayLastMonth,
        lastDayLastMonth,
      );

      String aiInsight = 'بداية موفقة! ابدأ البيع للحصول على تحليلات ذكية.';
      bool isPositiveInsight = true;

      if (lastMonthSales > 0) {
        final growth =
            ((currentMonthSales - lastMonthSales) / lastMonthSales) * 100;
        if (growth > 0) {
          aiInsight =
              'المبيعات هذا الشهر أعلى بنسبة ${growth.toStringAsFixed(1)}% عن الشهر الماضي';
          isPositiveInsight = true;
        } else if (growth < 0) {
          aiInsight =
              'المبيعات هذا الشهر أقل بنسبة ${growth.abs().toStringAsFixed(1)}% عن الشهر الماضي';
          isPositiveInsight = false;
        } else {
          aiInsight = 'المبيعات مستقرة هذا الشهر مقارنة بالشهر الماضي.';
          isPositiveInsight = true;
        }
      } else if (currentMonthSales > 0) {
        aiInsight = 'أداء ممتاز! مبيعات قوية في بداية استخدامك للنظام.';
        isPositiveInsight = true;
      }

      return DashboardStats(
        salesToday: MathUtils.round(totalSales),
        expensesToday: MathUtils.round(totalExpenses),
        netProfitToday: MathUtils.round(netProfit),
        cashInDrawer: cashInDrawer,
        lowStockCount: lowStockCount,
        returnsCount: returnsCount,
        debtsCount: 0,
        booksSoldToday: booksSoldToday,
        recentSales: recentSales,
        aiInsight: aiInsight,
        isPositiveInsight: isPositiveInsight,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<DashboardStats> getDashboardStatsStream() {
    late StreamController<DashboardStats> controller;
    final List<StreamSubscription> subs = [];

    void update() async {
      if (!controller.isClosed) {
        try {
          final stats = await getDashboardStats();
          if (!controller.isClosed) {
            controller.add(stats);
          }
        } catch (e) {
          if (!controller.isClosed) {
            controller.addError(e);
          }
        }
      }
    }

    controller = StreamController<DashboardStats>(
      onListen: () {
        update(); // Initial fetch

        // Watch Sales
        subs.add(_db.select(_db.sales).watch().listen((_) => update()));

        // Watch Expenses
        subs.add(_db.select(_db.expenses).watch().listen((_) => update()));

        // Watch Inventory (Books)
        subs.add(_db.select(_db.books).watch().listen((_) => update()));

        // Watch Supplier Returns
        subs.add(
          _db.select(_db.returnInvoices).watch().listen((_) => update()),
        );
      },
      onCancel: () {
        for (var s in subs) {
          s.cancel();
        }
      },
    );

    return controller.stream;
  }

  @override
  Future<List<Book>> getLowStockBooks() {
    return _booksDao.getLowStockBooks();
  }

  @override
  Future<List<Book>> getTopProfitBooks() async {
    final books = await _db.select(_db.books).get();
    return (books..sort((a, b) {
          final profitA = (a.sellPrice - a.costPrice) * a.totalSoldQty;
          final profitB = (b.sellPrice - b.costPrice) * b.totalSoldQty;
          return profitB.compareTo(profitA);
        }))
        .take(10)
        .toList();
  }

  @override
  Future<List<Supplier>> getTopSuppliers() async {
    return (_db.select(_db.suppliers)
          ..orderBy([
            (t) => OrderingTerm(expression: t.aiScore, mode: OrderingMode.desc),
          ])
          ..limit(10))
        .get();
  }

  @override
  Future<List<Supplier>> getSuppliersReport() async {
    return _suppliersDao.getAllSuppliers();
  }

  @override
  Stream<List<Supplier>> getSuppliersReportStream() {
    return _suppliersDao.streamAllSuppliers();
  }

  @override
  Future<List<Book>> getAllBooks() {
    return _db.select(_db.books).get();
  }

  @override
  Future<List<Book>> getDeadStockBooks() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 90));
    final soldQuery = _db.select(_db.saleItems).join([
      innerJoin(_db.sales, _db.sales.id.equalsExp(_db.saleItems.saleId)),
    ])..where(_db.sales.saleDate.isBiggerOrEqualValue(cutoff));

    final soldRows = await soldQuery.get();
    final soldBookIds = soldRows
        .map((row) => row.readTable(_db.saleItems).bookId)
        .toSet();

    final allBooks = await _db.select(_db.books).get();
    return allBooks.where((b) => !soldBookIds.contains(b.id)).toList();
  }

  @override
  Future<Map<String, int>> getSalesInLast30Days() async {
    final cutoff = DateTime.now().subtract(const Duration(days: 30));

    final query = _db.select(_db.saleItems).join([
      innerJoin(_db.sales, _db.sales.id.equalsExp(_db.saleItems.saleId)),
    ])..where(_db.sales.saleDate.isBiggerOrEqualValue(cutoff));

    final rows = await query.get();

    final Map<String, int> salesMap = {};
    for (var row in rows) {
      final item = row.readTable(_db.saleItems);
      salesMap[item.bookId] = (salesMap[item.bookId] ?? 0) + item.quantity;
    }
    return salesMap;
  }

  @override
  Future<List<DailySalesPoint>> getSalesChartData(
    DateTime start,
    DateTime end,
  ) async {
    final sales = await _salesDao.getSalesByDateRange(start, end);
    final Map<DateTime, double> salesByDate = {};

    for (var sale in sales) {
      final date = DateTime(
        sale.saleDate.year,
        sale.saleDate.month,
        sale.saleDate.day,
      );
      salesByDate[date] = (salesByDate[date] ?? 0.0) + sale.totalAmount;
    }

    final List<DailySalesPoint> points = [];
    salesByDate.forEach((date, total) {
      points.add(DailySalesPoint(day: date, totalSales: total));
    });

    points.sort((a, b) => a.day.compareTo(b.day));
    return points;
  }

  @override
  Future<FinancialReport> getFinancialReport(
    DateTime start,
    DateTime end,
  ) async {
    try {
      // 1. Calculate Total Sales (Sum of Sales.totalAmount)
      // 1. Calculate Total Sales (Sum of Sales.totalAmount)
      final totalRevenue = await _salesDao.getSalesTotalForDateRange(
        start,
        end,
      );

      // Verify Discounts
      final discountQuery = _db.selectOnly(_db.sales)
        ..addColumns([_db.sales.discountValue.sum()])
        ..where(_db.sales.saleDate.isBetween(Variable(start), Variable(end)));

      final discountResult = await discountQuery.getSingleOrNull();
      final totalDiscounts =
          discountResult?.read(_db.sales.discountValue.sum()) ?? 0.0;

      // 2. Calculate Cash Sales
      final cashQuery = _db.selectOnly(_db.sales)
        ..where(
          _db.sales.paymentType.equals('Cash') &
              _db.sales.saleDate.isBetween(Variable(start), Variable(end)),
        )
        ..addColumns([_db.sales.totalAmount.sum()]);

      final cashResult = await cashQuery.getSingleOrNull();
      final totalSalesCash =
          cashResult?.read(_db.sales.totalAmount.sum()) ?? 0.0;

      // 3. Calculate Credit Sales (Check for both 'Credit' and 'آجل')
      final creditQuery = _db.selectOnly(_db.sales)
        ..where(
          (_db.sales.paymentType.equals('Credit') |
                  _db.sales.paymentType.equals('آجل')) &
              _db.sales.saleDate.isBetween(Variable(start), Variable(end)),
        )
        ..addColumns([_db.sales.totalAmount.sum()]);

      final creditResult = await creditQuery.getSingleOrNull();
      final totalSalesCredit =
          creditResult?.read(_db.sales.totalAmount.sum()) ?? 0.0;

      // 4. Calculate Expenses
      // 4. Calculate Expenses
      final totalExpenses = await _expensesDao.getExpensesTotalForDateRange(
        start,
        end,
      );

      // 5. Calculate COGS (Cost of Goods Sold)
      // COGS = Sum(SaleItems.Quantity * SaleItems.UnitCostAtSale)
      // Must join with Sales table to filter by Date
      final cogsQuery = _db.selectOnly(_db.saleItems).join([
        innerJoin(_db.sales, _db.sales.id.equalsExp(_db.saleItems.saleId)),
      ])..where(_db.sales.saleDate.isBetween(Variable(start), Variable(end)));

      // Expression: quantity * unitCostAtSale
      // Note: quantity is int, cast to double usually helps avoid drift issues in expressions
      final cogsExpression =
          _db.saleItems.quantity.cast<double>() * _db.saleItems.unitCostAtSale;

      cogsQuery.addColumns([cogsExpression.sum()]);

      final cogsResult = await cogsQuery.getSingleOrNull();
      final totalCOGS = cogsResult?.read(cogsExpression.sum()) ?? 0.0;

      // 6. Net Profit Calculation with Safe Math
      // Net Profit = Revenue - COGS - Expenses
      double netProfit =
          totalRevenue - totalDiscounts - totalCOGS - totalExpenses;

      // Safety: Ensure no NaN/Infinity passes through
      if (netProfit.isNaN || netProfit.isInfinite) {
        netProfit = 0.0;
      }

      if (kDebugMode) {
        print('📊 PROFIT MATH CHECK:');
        print('(+) Total Sales Revenue: $totalRevenue');
        print('(-) Total Cost of Goods: $totalCOGS');
        print('(-) Total Invoice Discounts: $totalDiscounts');
        print('(-) Total Expenses: $totalExpenses');
        print('(=) Net Profit: $netProfit');
      }

      // 6b. Calculate Profit Margin % (for potential future use)
      double profitMarginPercent = 0.0;
      if (totalRevenue > 0) {
        profitMarginPercent = (netProfit / totalRevenue) * 100;
      }
      // Ensure no NaN/Infinity in margin
      if (profitMarginPercent.isNaN || profitMarginPercent.isInfinite) {
        profitMarginPercent = 0.0;
      }

      // 7. Top Profitable Items
      final topItemsQuery = _db.select(_db.saleItems).join([
        innerJoin(_db.sales, _db.sales.id.equalsExp(_db.saleItems.saleId)),
        innerJoin(_db.books, _db.books.id.equalsExp(_db.saleItems.bookId)),
      ])..where(_db.sales.saleDate.isBetween(Variable(start), Variable(end)));

      final rows = await topItemsQuery.get();
      final Map<String, _ItemStats> itemStats = {};

      for (var row in rows) {
        final saleItem = row.readTable(_db.saleItems);
        final book = row.readTable(_db.books);
        // Calculate Gross Profit: (Unit Price - Cost) * Quantity
        final profit =
            (saleItem.unitPrice - saleItem.unitCostAtSale) * saleItem.quantity;

        if (!itemStats.containsKey(book.id)) {
          itemStats[book.id] = _ItemStats(name: book.name, profit: 0.0);
        }
        itemStats[book.id]!.profit += profit;
      }

      final sortedStats = itemStats.values.toList()
        ..sort((a, b) => b.profit.compareTo(a.profit));

      final maxProfit = sortedStats.isNotEmpty
          ? (sortedStats.first.profit == 0 ? 1.0 : sortedStats.first.profit)
          : 1.0;

      final topProfitableItems = sortedStats
          .take(5)
          .toList()
          .asMap()
          .entries
          .map((entry) {
            final idx = entry.key;
            final stats = entry.value;
            return TopProfitableItem(
              rank: idx + 1,
              name: stats.name,
              profit: stats.profit,
              performance: stats.profit / maxProfit,
            );
          })
          .toList();

      return FinancialReport(
        totalRevenue: MathUtils.round(totalRevenue),
        totalSalesCash: MathUtils.round(totalSalesCash),
        totalSalesCredit: MathUtils.round(totalSalesCredit),
        totalCOGS: MathUtils.round(totalCOGS),
        totalExpenses: MathUtils.round(totalExpenses),
        netProfit: MathUtils.round(netProfit),
        topProfitableItems: topProfitableItems,
      );
    } catch (e) {
      return const FinancialReport();
    }
  }

  @override
  Stream<FinancialReport> getFinancialReportStream(
    DateTime start,
    DateTime end,
  ) {
    late StreamController<FinancialReport> controller;
    final List<StreamSubscription> subs = [];

    void update() async {
      if (!controller.isClosed) {
        try {
          final report = await getFinancialReport(start, end);
          if (!controller.isClosed) {
            controller.add(report);
          }
        } catch (e) {
          if (!controller.isClosed) {
            controller.addError(e);
          }
        }
      }
    }

    controller = StreamController<FinancialReport>(
      onListen: () {
        update(); // Initial fetch
        // Watch tables that affect financial reports
        subs.add(_db.select(_db.sales).watch().listen((_) => update()));
        subs.add(_db.select(_db.saleItems).watch().listen((_) => update()));
        subs.add(_db.select(_db.expenses).watch().listen((_) => update()));
        subs.add(
          _db.select(_db.books).watch().listen((_) => update()),
        ); // Cost price changes?
      },
      onCancel: () {
        for (var s in subs) {
          s.cancel();
        }
      },
    );

    return controller.stream;
  }

  @override
  Future<SupplierStats> getSupplierStats(String supplierId) async {
    // 1. Fetch Supplier Info
    final supplier = await (_db.select(
      _db.suppliers,
    )..where((t) => t.id.equals(supplierId))).getSingleOrNull();

    if (supplier == null) {
      throw Exception('Supplier not found');
    }

    final totalDebt = supplier.balance;
    final totalPaid = supplier.totalPaid;

    // 2. Fetch Invoices Count
    final invoices =
        await (_db.select(_db.purchaseInvoices)
              ..where((t) => t.supplierId.equals(supplierId))
              ..orderBy([
                (t) => OrderingTerm(
                  expression: t.invoiceDate,
                  mode: OrderingMode.desc,
                ),
              ]))
            .get();

    final invoiceCount = invoices.length;

    // 3. Calculate Real Weekly Activity (Last 7 weeks)
    final weeklyActivity = List.filled(7, 0.0);
    final now = DateTime.now();
    final startOfToday = DateTime(now.year, now.month, now.day);

    for (var invoice in invoices) {
      final daysDiff = startOfToday.difference(invoice.invoiceDate).inDays;
      if (daysDiff < 0) continue; // Future invoice?

      final weekIndex = daysDiff ~/ 7;
      if (weekIndex < 7) {
        // weekIndex 0 is current week, should be at index 6 of chart
        weeklyActivity[6 - weekIndex] += invoice.finalTotal;
      }
    }

    // 4. Return Rate Logic (Heuristic or Placeholder)
    const double returnRate = 0.0;

    // 5. Generate Arabic AI Insight
    final String aiInsight = returnRate > 20.0
        ? 'تحذير: معدل مرتجعات مرتفع (${returnRate.toStringAsFixed(1)}%). يرجى مراجعة الجودة.'
        : 'أداء ممتاز. مورد موثوق به وملتزم بالمواعيد.';

    return SupplierStats(
      totalDebt: totalDebt,
      totalPaid: totalPaid,
      invoiceCount: invoiceCount,
      returnRate: returnRate,
      weeklyActivity: weeklyActivity,
      aiInsight: aiInsight,
    );
  }

  @override
  Future<InvoiceDetailModel> getInvoiceDetails(String invoiceId) async {
    // 1. Fetch Invoice
    final invoice = await (_db.select(
      _db.purchaseInvoices,
    )..where((t) => t.id.equals(invoiceId))).getSingleOrNull();

    if (invoice == null) {
      throw Exception('Invoice not found');
    }

    // 2. Fetch Supplier
    final supplier = await (_db.select(
      _db.suppliers,
    )..where((t) => t.id.equals(invoice.supplierId))).getSingleOrNull();

    if (supplier == null) {
      throw Exception('Supplier not found');
    }

    // 3. Fetch Purchase Items with Book Names
    final itemsQuery = _db.select(_db.purchaseItems).join([
      innerJoin(_db.books, _db.books.id.equalsExp(_db.purchaseItems.bookId)),
    ])..where(_db.purchaseItems.invoiceId.equals(invoiceId));

    final rows = await itemsQuery.get();

    final items = rows.map((row) {
      final item = row.readTable(_db.purchaseItems);
      final book = row.readTable(_db.books);
      return PurchaseItemWithBook(item: item, bookName: book.name);
    }).toList();

    return InvoiceDetailModel(
      invoice: invoice,
      supplier: supplier,
      items: items,
    );
  }

  @override
  Future<double> getTotalSalesMTD(DateTime startOfMonth, DateTime now) async {
    final query = _db.selectOnly(_db.sales)
      ..addColumns([_db.sales.totalAmount.sum()])
      ..where(_db.sales.saleDate.isBetweenValues(startOfMonth, now));

    final result = await query
        .map((row) => row.read(_db.sales.totalAmount.sum()))
        .getSingleOrNull();
    return result ?? 0.0;
  }

  @override
  Future<int> getTotalCurrentStock() async {
    final query = _db.selectOnly(_db.books)
      ..addColumns([_db.books.currentStock.sum()]);
    final result = await query
        .map((row) => row.read(_db.books.currentStock.sum()))
        .getSingleOrNull();
    return result?.toInt() ?? 0;
  }

  @override
  Future<double> getTotalInventoryValue() async {
    try {
      // Fetch all books to calculate inventory value
      final books = await _db.select(_db.books).get();

      double totalValue = 0.0;

      for (final book in books) {
        // CRITICAL: Treat negative stock as ZERO to prevent distorted values
        final effectiveStock = book.currentStock > 0 ? book.currentStock : 0;
        totalValue += effectiveStock * book.costPrice;
      }

      // Apply precision rounding
      return MathUtils.round(totalValue);
    } catch (e) {
      return 0.0;
    }
  }

  @override
  Future<double> getTotalPaidToSuppliers() async {
    // FIX: Using Suppliers.totalPaid as the Single Source of Truth.
    // Explicitly ignoring PurchaseInvoices.paidAmount to avoid Double Counting.
    // Suppliers.totalPaid accumulates ALL payments (manual + invoice-based).
    final suppliersQuery = _db.selectOnly(_db.suppliers)
      ..addColumns([_db.suppliers.totalPaid.sum()]);
    final suppliersResult = await suppliersQuery.getSingleOrNull();
    return suppliersResult?.read(_db.suppliers.totalPaid.sum()) ?? 0.0;
  }
}

class _ItemStats {
  final String name;
  double profit;
  _ItemStats({required this.name, required this.profit});
}
