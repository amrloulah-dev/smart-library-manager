import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/database/daos/books_dao.dart';
import 'package:librarymanager/core/database/daos/customers_dao.dart';
import 'package:librarymanager/core/database/daos/sales_dao.dart';
import 'package:librarymanager/core/utils/math_utils.dart';
import 'package:librarymanager/features/sales/domain/repositories/sales_repository.dart';

@LazySingleton(as: SalesRepository)
class SalesRepositoryImpl implements SalesRepository {
  final AppDatabase _db;
  final SalesDao _salesDao;
  final CustomersDao _customersDao;
  final BooksDao _booksDao;

  SalesRepositoryImpl(
    this._db,
    this._salesDao,
    this._customersDao,
    this._booksDao,
  );

  @override
  Future<void> processSaleTransaction({
    required SalesCompanion sale,
    required List<SaleItemsCompanion> items,
    String? customerId,
    String? linkedReservationId,
  }) async {
    return _db.transaction(() async {
      // 1. Fetch all affected books to calculate new stocks
      final bookIds = items.map((e) => e.bookId.value).toSet();
      final books = await (_db.select(
        _db.books,
      )..where((t) => t.id.isIn(bookIds))).get();

      // 2. Calculate new stocks internally
      final List<Book> updatedBooks = [];
      for (var book in books) {
        // Calculate total quantity sold for this book in this transaction
        int qtySold = 0;
        for (var item in items) {
          if (item.bookId.value == book.id) {
            qtySold += item.quantity.value;
          }
        }

        // Add to updated list with new stock and date
        updatedBooks.add(
          book.copyWith(
            currentStock: book.currentStock - qtySold,
            lastSaleDate: Value(DateTime.now()),
          ),
        );
      }

      // 3. Call Batched DAO Method
      await _salesDao.processSaleBatch(sale, items, updatedBooks);

      // 4. Update Customer Balance if needed (Independent of batch, but same transaction)
      if (customerId != null) {
        final remaining = sale.remainingAmount.value;
        if (remaining > 0) {
          await _customersDao.updateCustomerBalance(customerId, remaining);
        }
      }

      // 5. Update Reservation Status if linked
      if (linkedReservationId != null) {
        // Use custom update for reservations
        await (_db.update(_db.reservations)
              ..where((t) => t.id.equals(linkedReservationId)))
            .write(const ReservationsCompanion(status: Value('Completed')));
      }
    });
  }

  @override
  Future<void> processExchange({
    required List<Book> returnedItems,
    required List<Book> newItems,
    double? finalNewItemPrice,
    double? finalReturnItemRefund,
  }) async {
    return _db.transaction(() async {
      // 1. Handle Returns
      for (final book in returnedItems) {
        // Use the provided discounted refund amount, or fallback to original price
        // Apply MathUtils.round() to prevent floating point errors
        final refundAmount = MathUtils.round(
          finalReturnItemRefund ?? book.sellPrice,
        );

        await _db
            .into(_db.salesReturns)
            .insert(
              SalesReturnsCompanion(
                bookId: Value(book.id),
                quantity: const Value(1),
                refundAmount: Value(refundAmount),
                reason: const Value('Exchange'),
                returnDate: Value(DateTime.now()),
              ),
            );
        await _booksDao.updateStock(book.id, 1);
      }

      // 2. Handle New Sales
      if (newItems.isNotEmpty) {
        // Use the provided discounted price, or fallback to original price
        final newBook = newItems.first;
        final effectivePrice = MathUtils.round(
          finalNewItemPrice ?? newBook.sellPrice,
        );

        double totalAmount = 0.0;
        double totalProfit = 0.0;

        for (final book in newItems) {
          // For single-item exchange, use effectivePrice; for multiple items, use original
          final unitPrice = MathUtils.round(
            (newItems.length == 1) ? effectivePrice : book.sellPrice,
          );
          totalAmount += unitPrice;
          totalProfit += MathUtils.round(unitPrice - book.costPrice);
        }

        // Round final totals
        totalAmount = MathUtils.round(totalAmount);
        totalProfit = MathUtils.round(totalProfit);

        final saleId = await _salesDao.insertSale(
          SalesCompanion(
            saleDate: Value(DateTime.now()),
            paymentType: const Value('Cash'),
            totalAmount: Value(totalAmount),
            discountValue: const Value(0.0),
            paidAmount: Value(totalAmount),
            remainingAmount: const Value(0.0),
            totalProfit: Value(totalProfit),
          ),
        );

        final saleItems = newItems.asMap().entries.map((entry) {
          final book = entry.value;
          // For single-item exchange, use effectivePrice; for multiple items, use original
          final unitPrice = MathUtils.round(
            (newItems.length == 1) ? effectivePrice : book.sellPrice,
          );
          return SaleItemsCompanion(
            saleId: Value(saleId),
            bookId: Value(book.id),
            quantity: const Value(1),
            unitPrice: Value(unitPrice),
            unitCostAtSale: Value(MathUtils.round(book.costPrice)),
          );
        }).toList();

        await _salesDao.insertSaleItems(saleItems);

        for (final book in newItems) {
          await _booksDao.updateStock(book.id, -1);
        }
      }
    });
  }

  @override
  Stream<List<Sale>> streamSalesHistory() {
    return _salesDao.streamAllSales();
  }
}
