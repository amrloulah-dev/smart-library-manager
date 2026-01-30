import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/database/daos/books_dao.dart';
import 'package:librarymanager/core/database/daos/suppliers_dao.dart';
import 'package:librarymanager/core/database/daos/smart_settings_dao.dart';
import 'package:librarymanager/core/utils/math_utils.dart';
import 'package:librarymanager/features/inventory/domain/models/book_search_query.dart';
import 'package:librarymanager/features/inventory/domain/models/inventory_filter.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/invoices/domain/models/scanned_item_model.dart';
import 'package:librarymanager/features/reports/domain/models/item_history_model.dart';
import '../../../../core/utils/text_normalizer.dart';

@LazySingleton(as: InventoryRepository)
class InventoryRepositoryImpl implements InventoryRepository {
  final BooksDao _booksDao;
  final SuppliersDao _suppliersDao;
  final SmartSettingsDao _smartSettingsDao;
  final AppDatabase _db;

  InventoryRepositoryImpl(
    this._booksDao,
    this._suppliersDao,
    this._db,
    this._smartSettingsDao,
  );

  @override
  Future<void> deletePurchaseInvoice(String invoiceId) async {
    return _db.transaction(() async {
      // 1. Fetch Invoice
      final invoice = await (_db.select(
        _db.purchaseInvoices,
      )..where((t) => t.id.equals(invoiceId))).getSingleOrNull();

      if (invoice == null) {
        throw Exception('Invoice not found');
      }

      // 2. Fetch Items
      final items = await (_db.select(
        _db.purchaseItems,
      )..where((t) => t.invoiceId.equals(invoiceId))).get();

      // 3. Revert Inventory (Stock Deduction)
      for (final item in items) {
        await _booksDao.updateStock(item.bookId, -item.quantity);
      }

      // 4. Revert Supplier Balance
      final paidAmount = invoice.paidAmount ?? 0.0;
      final netDebtAdded = invoice.finalTotal - paidAmount;

      final supplier = await (_db.select(
        _db.suppliers,
      )..where((t) => t.id.equals(invoice.supplierId))).getSingleOrNull();

      if (supplier != null) {
        final newBalance = supplier.balance - netDebtAdded;
        final newTotalPaid = supplier.totalPaid - paidAmount;

        await (_db.update(
          _db.suppliers,
        )..where((t) => t.id.equals(supplier.id))).write(
          SuppliersCompanion(
            balance: Value(newBalance),
            totalPaid: Value(newTotalPaid),
          ),
        );
      }

      // 5. Delete Records
      await (_db.delete(
        _db.purchaseItems,
      )..where((t) => t.invoiceId.equals(invoiceId))).go();

      await (_db.delete(
        _db.purchaseInvoices,
      )..where((t) => t.id.equals(invoiceId))).go();
    });
  }

  @override
  Future<void> createPurchaseInvoice(
    String supplierId,
    List<ScannedItemModel> items,
    double discount,
    DateTime date, {
    double paidAmount = 0.0,
  }) {
    return _db.transaction(() async {
      double totalBeforeDiscount = 0;
      for (final item in items) {
        totalBeforeDiscount += (item.price * item.quantity);
      }
      final finalTotal = totalBeforeDiscount - discount;

      // 2. Create Invoice
      final invoice = await _db
          .into(_db.purchaseInvoices)
          .insertReturning(
            PurchaseInvoicesCompanion(
              supplierId: Value(supplierId),
              invoiceDate: Value(date),
              createdAt: Value(DateTime.now()),
              totalBeforeDiscount: Value(totalBeforeDiscount),
              discountValue: Value(discount),
              finalTotal: Value(finalTotal),
              paidAmount: Value(paidAmount), // ✅ FIX: Add paidAmount
            ),
          );
      final invoiceId = invoice.id;

      // 3. Process Items
      for (final item in items) {
        // Check if book exists by name
        // Normalized name search could be better, but exact match for now
        final cleanName = TextNormalizer.standardizeBookName(item.name);

        var book = await (_db.select(
          _db.books,
        )..where((t) => t.name.equals(cleanName))).getSingleOrNull();

        String bookId;
        if (book == null) {
          // Create new book
          // We set costPrice/sellPrice from invoice.
          // Apply MathUtils.round() to prevent floating point precision errors
          final costPrice = MathUtils.round(item.price);
          final sellPrice = MathUtils.round(item.sellPrice ?? costPrice * 1.25);

          final newBook = await _db
              .into(_db.books)
              .insertReturning(
                BooksCompanion(
                  name: Value(cleanName),
                  costPrice: Value(costPrice),
                  sellPrice: Value(sellPrice),
                  currentStock: Value(item.quantity),
                  minLimit: const Value(5),
                  totalSoldQty: const Value(0),
                  reservedQuantity: const Value(0),
                  lastSupplyDate: Value(date),
                ),
              );
          bookId = newBook.id;
        } else {
          bookId = book.id;
          // Update stock and cost (Weighted Average Cost)
          final newStock = book.currentStock + item.quantity;

          // Safe Weighted Average Cost calculation with zero-division guard
          double newAvgCost;
          if (newStock <= 0) {
            // Edge Case: Stock is still negative or zero after this purchase.
            // Safety: Adopt the new incoming price as the standard cost to avoid /0.
            newAvgCost = MathUtils.round(item.price);
          } else {
            // Simple Weighted Average Cost: ((OldStock * OldCost) + (NewQty * NewCost)) / (OldStock + NewQty)
            final oldTotalVal = book.currentStock * book.costPrice;
            final newTotalVal = item.quantity * item.price;
            newAvgCost = MathUtils.round(
              (oldTotalVal + newTotalVal) / newStock,
            );
          }

          // Final safety check for NaN/Infinity
          if (newAvgCost.isNaN || newAvgCost.isInfinite) {
            newAvgCost = MathUtils.round(item.price);
          }

          await (_db.update(
            _db.books,
          )..where((t) => t.id.equals(bookId))).write(
            BooksCompanion(
              currentStock: Value(newStock),
              costPrice: Value(newAvgCost),
              lastSupplyDate: Value(date),
            ),
          );
        }

        // Create Purchase Item
        await _db
            .into(_db.purchaseItems)
            .insert(
              PurchaseItemsCompanion(
                invoiceId: Value(invoiceId),
                bookId: Value(bookId),
                quantity: Value(item.quantity),
                unitCost: Value(item.price),
              ),
            );
      }

      // 4. Update Supplier Balance
      // Calculate Net Debt: finalTotal - paidAmount
      // Only the unpaid portion increases supplier balance (what we owe)
      final netDebt = finalTotal - paidAmount;

      final supplier = await (_db.select(
        _db.suppliers,
      )..where((t) => t.id.equals(supplierId))).getSingle();

      final newBalance = supplier.balance + netDebt;
      final newTotalPaid = supplier.totalPaid + paidAmount;

      print('📝 DEBUG SAVE: Inserting Invoice with paidAmount: $paidAmount');
      await (_db.update(
        _db.suppliers,
      )..where((t) => t.id.equals(supplierId))).write(
        SuppliersCompanion(
          balance: Value(newBalance),
          totalPaid: Value(newTotalPaid),
        ),
      );
      print('📝 DEBUG SAVE: Updated Supplier totalPaid to: $newTotalPaid');
    });
  }

  @override
  Stream<List<Book>> streamAllBooks() {
    return _booksDao.streamAllBooks();
  }

  @override
  Stream<List<Supplier>> streamAllSuppliers() {
    return _suppliersDao.streamAllSuppliers();
  }

  @override
  Future<int> insertBook(BooksCompanion book) async {
    // 1. Normalize the name
    final rawName = book.name.value;
    final normalizedName = TextNormalizer.standardizeBookName(rawName);

    return _db.transaction(() async {
      // 2. Check for existence (Normalized)
      final existingBook = await (_db.select(
        _db.books,
      )..where((t) => t.name.equals(normalizedName))).getSingleOrNull();

      if (existingBook != null) {
        // 3. Update Existing (Upsert Logic)
        final newQty = existingBook.currentStock + book.currentStock.value;

        // Optionally update prices if new ones are provided/different
        // We choose to update to the latest prices entered
        await (_db.update(
          _db.books,
        )..where((t) => t.id.equals(existingBook.id))).write(
          BooksCompanion(
            currentStock: Value(newQty),
            costPrice: book.costPrice,
            sellPrice: book.sellPrice,
            lastSupplyDate: Value(DateTime.now()),
          ),
        );
        return 0; // Return 0 or existing ID to indicate update?
        // Drift insert usually returns RowID (int).
        // We can return -1 or the existing rowId if needed.
        // For now, let's return -1 to indicate "Updated, not Created"
        // or just 1 for success.
      } else {
        // 4. Insert New
        // Ensure we save the normalized name
        final newBook = book.copyWith(name: Value(normalizedName));
        return _booksDao.insertBook(newBook);
      }
    });
  }

  @override
  Future<int> insertSupplier(SuppliersCompanion supplier) {
    return _suppliersDao.insertSupplier(supplier);
  }

  @override
  Future<void> addSupplier({
    required String name,
    String? phone,
    String? address,
    int? leadTime,
    bool isReturnable = true,
    int returnPolicyDays = 90,
  }) async {
    await _suppliersDao.insertSupplier(
      SuppliersCompanion(
        name: Value(name),
        phone: Value(phone),
        address: Value(address),
        leadTime: Value(leadTime),
        lastUpdated: Value(DateTime.now()),
        isReturnable: Value(isReturnable),
        returnPolicyDays: Value(returnPolicyDays),
      ),
    );
  }

  @override
  Future<List<Book>> findBookByAttributes(BookSearchQuery query) {
    return _booksDao.findBookByAttributes(query);
  }

  @override
  Future<Book?> findBookByName(String name) {
    return (_db.select(
      _db.books,
    )..where((t) => t.name.equals(name))).getSingleOrNull();
  }

  @override
  Future<Book?> getBookById(String bookId) {
    return (_db.select(
      _db.books,
    )..where((t) => t.id.equals(bookId))).getSingleOrNull();
  }

  @override
  Future<void> updateBookStock(String bookId, int quantityChange) {
    return _booksDao.updateStock(bookId, quantityChange);
  }

  @override
  Future<void> updateSupplierBalance(String id, double amount) {
    return _suppliersDao.updateSupplierBalance(id, amount);
  }

  @override
  Future<void> processSupplierTransaction(
    String id,
    double amount, {
    bool isPayment = true,
  }) {
    return _suppliersDao.processPaymentTransaction(
      id,
      amount,
      isPayment: isPayment,
    );
  }

  @override
  @override
  Future<void> processSupplierReturn(
    String supplierId,
    Map<Book, int> itemsToReturn,
    double discountPercentage,
  ) {
    return _db.transaction(() async {
      double totalReturnAmount = 0;

      // 1. Calculate Total Amount
      for (final entry in itemsToReturn.entries) {
        final book = entry.key;
        final returnQty = entry.value;
        totalReturnAmount += (book.costPrice * returnQty);
      }

      final double netDeduction =
          totalReturnAmount * (1 - (discountPercentage / 100));

      // 2. Create Return Invoice Log
      final returnInvoice = await _db
          .into(_db.returnInvoices)
          .insertReturning(
            ReturnInvoicesCompanion(
              supplierId: Value(supplierId),
              returnDate: Value(DateTime.now()),
              totalAmount: Value(MathUtils.round(totalReturnAmount)),
              discountPercentage: Value(discountPercentage),
              finalAmount: Value(MathUtils.round(netDeduction)),
            ),
          );

      // 3. Process Items & Update Stock
      for (final entry in itemsToReturn.entries) {
        final book = entry.key;
        final qty = entry.value;

        // Decrement Stock
        await _booksDao.updateStock(book.id, -qty);

        // Record Return Item
        await _db
            .into(_db.returnItems)
            .insert(
              ReturnItemsCompanion(
                returnId: Value(returnInvoice.id),
                bookId: Value(book.id),
                quantity: Value(qty),
                unitCostAtReturn: Value(book.costPrice),
              ),
            );
      }

      // 4. Update Supplier Balance (Decrease what we owe)
      // Since updateSupplierBalance adds to the balance, we pass negative netDeduction
      await _suppliersDao.updateSupplierBalance(supplierId, -netDeduction);
    });
  }

  @override
  Future<List<Book>> getLowStockBooks() {
    return _booksDao.getLowStockBooks();
  }

  @override
  Future<Customer> createCustomer(CustomersCompanion customer) {
    return _db.into(_db.customers).insertReturning(customer);
  }

  @override
  Future<List<Customer>> searchCustomers(String query) {
    return (_db.select(
          _db.customers,
        )..where((tbl) => tbl.name.contains(query) | tbl.phone.contains(query)))
        .get();
  }

  @override
  Future<ItemHistoryResult> getItemHistory(String bookId) async {
    final List<ItemMovementEvent> events = [];
    final Map<String, int> supplierBreakdown = {};
    double totalGrossProfit = 0.0;

    // 1. Fetch Purchases
    final purchaseQuery = _db.select(_db.purchaseItems).join([
      innerJoin(
        _db.purchaseInvoices,
        _db.purchaseInvoices.id.equalsExp(_db.purchaseItems.invoiceId),
      ),
      innerJoin(
        _db.suppliers,
        _db.suppliers.id.equalsExp(_db.purchaseInvoices.supplierId),
      ),
    ])..where(_db.purchaseItems.bookId.equals(bookId));

    final purchaseRows = await purchaseQuery.get();

    for (var row in purchaseRows) {
      final item = row.readTable(_db.purchaseItems);
      final invoice = row.readTable(_db.purchaseInvoices);
      final supplier = row.readTable(_db.suppliers);

      // Track stats
      supplierBreakdown[supplier.name] =
          (supplierBreakdown[supplier.name] ?? 0) + item.quantity;

      events.add(
        ItemMovementEvent(
          date: invoice.invoiceDate,
          type: InventoryEventType.purchase,
          quantity: item.quantity,
          price: item.unitCost,
          entityName: supplier.name,
          referenceId: invoice.id.substring(0, 8), // Short ID
        ),
      );
    }

    // 2. Fetch Sales
    final salesQuery = _db.select(_db.saleItems).join([
      innerJoin(_db.sales, _db.sales.id.equalsExp(_db.saleItems.saleId)),
      leftOuterJoin(
        _db.customers,
        _db.customers.id.equalsExp(_db.sales.customerId),
      ),
    ])..where(_db.saleItems.bookId.equals(bookId));

    final salesRows = await salesQuery.get();

    for (var row in salesRows) {
      final item = row.readTable(_db.saleItems);
      final sale = row.readTable(_db.sales);
      final customer = row.readTableOrNull(_db.customers);

      // Calculate Profit
      totalGrossProfit +=
          (item.unitPrice - item.unitCostAtSale) * item.quantity;

      events.add(
        ItemMovementEvent(
          date: sale.saleDate,
          type: InventoryEventType.sale,
          quantity: item.quantity,
          price: item.unitPrice,
          entityName: customer?.name ?? 'عميل عام',
          referenceId: sale.id.substring(0, 8),
        ),
      );
    }

    // 3. Fetch Returns (Customer Returns)
    final returns = await (_db.select(
      _db.salesReturns,
    )..where((t) => t.bookId.equals(bookId))).get();

    for (var ret in returns) {
      events.add(
        ItemMovementEvent(
          date: ret.returnDate,
          type: InventoryEventType.customerReturn,
          quantity: ret.quantity,
          price: ret.refundAmount / (ret.quantity == 0 ? 1 : ret.quantity),
          entityName: 'مرتجع من عميل',
          referenceId: ret.reason, // Use reason as reference
        ),
      );
    }

    // 4. Sort by Date Descending
    events.sort((a, b) => b.date.compareTo(a.date));

    // 5. Calculate Best Supplier
    String bestSupplier = 'N/A';
    if (supplierBreakdown.isNotEmpty) {
      final sortedSuppliers = supplierBreakdown.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      bestSupplier = sortedSuppliers.first.key;
    }

    // 6. Calculate Turnover (Simple: Total Sold / Total Days in period)
    // Or just time between first purchase and last sale?
    // Let's use simple logic: If we have sales, average time between sales?
    // User requested "Turnover: Sells every 2 days".
    // Logic: (Last Sale Date - First Sale Date) / Total Sales Count
    double avgTurnoverDays = 0.0;
    final saleEvents = events
        .where((e) => e.type == InventoryEventType.sale)
        .toList();
    if (saleEvents.length > 1) {
      // Create separate list sorted ASC for time calc
      final sortedSales = List<ItemMovementEvent>.from(saleEvents)
        ..sort((a, b) => a.date.compareTo(b.date));
      final duration = sortedSales.last.date
          .difference(sortedSales.first.date)
          .inDays;
      if (duration > 0 && saleEvents.isNotEmpty) {
        avgTurnoverDays = duration / saleEvents.length;
      }
    }

    return ItemHistoryResult(
      events: events,
      stats: ItemStats(
        totalProfit: totalGrossProfit,
        bestSupplier: bestSupplier,
        avgTurnoverDays: avgTurnoverDays,
        supplierBreakdown: supplierBreakdown,
      ),
    );
  }

  @override
  Future<Map<String, int>> getAllGradeTargets() {
    return _smartSettingsDao.getAllGradeTargets();
  }

  @override
  Future<DateTime?> getSeasonEndDate() {
    return _smartSettingsDao.getSeasonEndDate();
  }

  @override
  Future<int?> getTargetForGrade(String grade) {
    return _smartSettingsDao.getTargetForGrade(grade);
  }

  @override
  Future<void> setSeasonEndDate(DateTime date) {
    return _smartSettingsDao.setSeasonEndDate(date);
  }

  @override
  Future<List<Book>> getBooksPaginated({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
    InventoryFilter? filter,
  }) async {
    final result = await _booksDao.getBooksPaginated(
      limit: limit,
      offset: offset,
      searchQuery: searchQuery,
      filter: filter,
    );
    return result;
  }

  @override
  Future<void> deleteBook(String bookId) {
    return (_db.delete(_db.books)..where((t) => t.id.equals(bookId))).go();
  }

  @override
  Future<void> updateBookDetails(BooksCompanion book) {
    // FIX: Enforce normalization/standardization to ensure search consistency
    var finalBook = book;
    if (book.name.present) {
      final normalizedName = TextNormalizer.standardizeBookName(
        book.name.value,
      );
      finalBook = book.copyWith(name: Value(normalizedName));
    }

    return (_db.update(
      _db.books,
    )..where((t) => t.id.equals(book.id.value))).write(finalBook);
  }

  @override
  Future<void> setTargetForGrade(String grade, int count) {
    return _smartSettingsDao.setTargetForGrade(grade, count);
  }

  @override
  Future<void> repairBooks() {
    return _booksDao.repairBookNormalization();
  }
}
