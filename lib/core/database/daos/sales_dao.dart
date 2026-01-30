import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';

part 'sales_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [Sales, SaleItems])
class SalesDao extends DatabaseAccessor<AppDatabase> with _$SalesDaoMixin {
  SalesDao(super.db);

  Future<String> insertSale(SalesCompanion sale) async {
    final row = await into(sales).insertReturning(sale);
    return row.id;
  }

  Future<void> insertSaleItems(List<SaleItemsCompanion> items) async {
    await batch((batch) {
      batch.insertAll(saleItems, items);
    });
  }

  Future<List<Sale>> getSalesByDateRange(DateTime start, DateTime end) {
    return (select(sales)
          ..where((t) => t.saleDate.isBetween(Variable(start), Variable(end))))
        .get();
  }

  Stream<List<Sale>> streamAllSales() {
    return (select(sales)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.saleDate, mode: OrderingMode.desc),
          ])
          ..limit(100))
        .watch();
  }

  Future<List<Sale>> getRecentSales(int limit) {
    return (select(sales)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.saleDate, mode: OrderingMode.desc),
          ])
          ..limit(limit))
        .get();
  }

  Future<Map<DateTime, int>> getDailySalesForBook(
    String bookId,
    DateTime startDate,
  ) async {
    final query =
        select(
            saleItems,
          ).join([innerJoin(sales, sales.id.equalsExp(saleItems.saleId))])
          ..where(saleItems.bookId.equals(bookId))
          ..where(sales.saleDate.isBiggerOrEqualValue(startDate));

    final result = await query.get();

    final Map<DateTime, int> history = {};
    for (var row in result) {
      final saleDate = row.readTable(sales).saleDate;
      final quantity = row.readTable(saleItems).quantity;

      // Normalize date to YYYY-MM-DD
      final dateKey = DateTime(saleDate.year, saleDate.month, saleDate.day);
      history[dateKey] = (history[dateKey] ?? 0) + quantity;
    }
    return history;
  }

  /// Get all sale items within a date range (joined with sales)
  Future<List<SaleItem>> getAllSalesInRange(
    DateTime start,
    DateTime end,
  ) async {
    final query = select(saleItems).join([
      innerJoin(sales, sales.id.equalsExp(saleItems.saleId)),
    ])..where(sales.saleDate.isBetween(Variable(start), Variable(end)));

    final result = await query.get();
    return result.map((row) => row.readTable(saleItems)).toList();
  }

  /// Get total sales amount for a specific date range using SQL aggregation
  Future<double> getSalesTotalForDateRange(DateTime start, DateTime end) async {
    final query = selectOnly(sales)..addColumns([sales.totalAmount.sum()]);
    query.where(sales.saleDate.isBetween(Variable(start), Variable(end)));
    final result = await query.getSingleOrNull();
    return result?.read(sales.totalAmount.sum()) ?? 0.0;
  }

  /// Process a full sale transaction in a single batch
  /// 1. Inserts the Sale
  /// 2. Batch inserts all SaleItems
  /// 3. Batch updates updated Book stocks
  Future<void> processSaleBatch(
    SalesCompanion sale,
    List<SaleItemsCompanion> items,
    List<Book> booksToUpdate,
  ) {
    return transaction(() async {
      // 1. Insert Sale Header
      final saleRow = await into(sales).insertReturning(sale);
      final saleId = saleRow.id;

      // 2. Batch Insert Items & Update Stock
      await batch((batch) {
        // Insert all SaleItems with the new saleId
        // Note: items passed here should rely on this assignment
        batch.insertAll(
          saleItems,
          items.map((i) => i.copyWith(saleId: Value(saleId))).toList(),
        );

        // Update Stocks
        for (var book in booksToUpdate) {
          // We apply the absolute values from the 'book' object (pre-calculated)
          batch.update(
            db.books,
            BooksCompanion(
              currentStock: Value(book.currentStock),
              lastSaleDate: Value(book.lastSaleDate),
              isSynced: const Value(false),
            ),
            where: (tbl) => tbl.id.equals(book.id),
          );
        }
      });
    });
  }

  Stream<double> watchSalesTotal(DateTime start, DateTime end) {
    final query = selectOnly(sales)..addColumns([sales.totalAmount.sum()]);
    query.where(sales.saleDate.isBetween(Variable(start), Variable(end)));
    return query.watchSingle().map(
      (row) => row.read(sales.totalAmount.sum()) ?? 0.0,
    );
  }

  Stream<int> watchReturnsCount(DateTime start, DateTime end) {
    // Assuming SalesReturns are in db.salesReturns. SalesDao might not have direct access if not in accessor table.
    // But we are in SalesDao which accesses 'Sales' and 'SaleItems'.
    // SalesReturns is likely another table.
    // Ideally this should be in SalesReturnsDao, but for Dashboard convenience we often put it here or use ReportsRepostiory.
    // I will leave Returns to ReportsRepository via table triggers.
    return const Stream.empty(); // Placeholder
  }
}
