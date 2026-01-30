import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/domain/models/book_search_query.dart';
import 'package:librarymanager/features/inventory/domain/models/inventory_filter.dart';
import 'package:librarymanager/core/utils/text_normalizer.dart';

part 'books_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [Books])
class BooksDao extends DatabaseAccessor<AppDatabase> with _$BooksDaoMixin {
  BooksDao(super.db);

  Stream<List<Book>> streamAllBooks() {
    return select(books).watch();
  }

  Stream<List<Book>> watchBooks(String? searchQuery) {
    final query = select(books);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query.where((tbl) => tbl.name.contains(searchQuery));
    }

    // CRITICAL FIX: Sort by 'name', causing NULL normalizedNames (if any) to still appear.
    query.orderBy([
      (t) => OrderingTerm(expression: t.name, mode: OrderingMode.asc),
    ]);

    return query.watch();
  }

  Future<List<Book>> findBookByAttributes(BookSearchQuery query) async {
    // 1. Fetch all books to apply robust normalization in Dart
    // (SQL LIKE is insufficient for complex unicode normalization)
    final allBooks = await select(books).get();

    // 2. Prepare normalized keywords
    final String? normPub = query.publisher != null
        ? TextNormalizer.standardizeBookName(query.publisher!)
        : null;
    final String? normSub = query.subject != null
        ? TextNormalizer.standardizeBookName(query.subject!)
        : null;
    final String? normGrade = query.grade != null
        ? TextNormalizer.standardizeBookName(query.grade!)
        : null;
    final String? normTerm = query.term != null
        ? TextNormalizer.standardizeBookName(query.term!)
        : null;

    // 3. Filter
    final filtered = allBooks.where((book) {
      final bookNameNorm = TextNormalizer.standardizeBookName(book.name);

      bool matches = true;

      if (normPub != null) {
        if (!bookNameNorm.contains(normPub)) matches = false;
      }
      if (normSub != null) {
        if (!bookNameNorm.contains(normSub)) matches = false;
      }
      if (normGrade != null) {
        if (!bookNameNorm.contains(normGrade)) matches = false;
      }
      if (normTerm != null) {
        if (!bookNameNorm.contains(normTerm)) matches = false;
      }

      return matches;
    }).toList();

    return filtered;
  }

  Future<int> insertBook(BooksCompanion book) {
    return into(books).insert(book);
  }

  Future<void> updateStock(String bookId, int quantityChange) {
    return transaction(() async {
      final book = await (select(
        books,
      )..where((t) => t.id.equals(bookId))).getSingleOrNull();
      if (book != null) {
        final newStock = book.currentStock + quantityChange;
        await (update(books)..where((t) => t.id.equals(bookId))).write(
          BooksCompanion(
            currentStock: Value(newStock),
            isSynced: const Value(false),
          ),
        );
      }
    });
  }

  Future<List<Book>> getBooksPaginated({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
    InventoryFilter? filter,
  }) {
    final query = select(books);

    // 1. Apply Search Filter
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final s = searchQuery.toLowerCase();
      // Simple contains check for name and publisher
      query.where(
        (tbl) =>
            tbl.name.lower().contains(s) | tbl.publisher.lower().contains(s),
      );
    }

    // 2. Apply Inventory Filters
    if (filter != null) {
      switch (filter) {
        case InventoryFilter.lowStock:
          query.where((tbl) => tbl.currentStock.isSmallerThan(tbl.minLimit));
          break;
        case InventoryFilter.bestSeller:
          // For Best Seller, we want to see high-selling items first.
          // We don't necessarily filter them out, just sort them?
          // Cubit implementation: "filtered.sort(...)". So it's a Sort.
          query.orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.totalSoldQty,
              mode: OrderingMode.desc,
            ),
          ]);
          break;
        case InventoryFilter.reserved:
          query.where((tbl) => tbl.reservedQuantity.isBiggerThanValue(0));
          break;
        case InventoryFilter.all:
          // Default ordering (e.g. by Name)
          query.orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.name,
              mode: OrderingMode.asc,
              nulls: NullsOrder.last,
            ),
          ]);
          break;
      }
    }

    // 3. Apply Pagination
    query.limit(limit, offset: offset);

    return query.get();
  }

  Future<void> repairBookNormalization() async {
    final allBooks = await select(books).get();

    await batch((batch) {
      for (final book in allBooks) {
        final expected = TextNormalizer.standardizeBookName(book.name);

        // If data is inconsistent (normalization rules changed or manual edit corruption)
        if (book.name != expected && expected.isNotEmpty) {
          batch.update(
            books,
            BooksCompanion(name: Value(expected)),
            where: (tbl) => tbl.id.equals(book.id),
          );
        }
      }
    });
  }

  Future<List<Book>> getLowStockBooks() {
    return (select(books)..where((t) => t.currentStock.equals(0))).get();
  }
}
