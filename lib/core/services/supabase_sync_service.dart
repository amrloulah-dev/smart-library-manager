import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:librarymanager/core/database/app_database.dart';

// Custom serializer to handle DateTime as ISO8601 string for Supabase
class _SupabaseJsonSerializer extends ValueSerializer {
  const _SupabaseJsonSerializer();

  @override
  T fromJson<T>(dynamic json) {
    throw UnimplementedError('fromJson is not needed for push sync');
  }

  @override
  dynamic toJson<T>(T value) {
    if (value is DateTime) {
      return value.toIso8601String();
    }
    return value;
  }
}

@lazySingleton
class SupabaseSyncService {
  final AppDatabase _db;
  final SupabaseClient _supabase;
  static const int _batchSize = 50;

  SupabaseSyncService(this._db, this._supabase);

  Future<void> syncPendingData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.id;

    // 1. Sync Base Entities (Parents)
    // If any of these fail critically, children will likely fail with FK errors.
    // We try to sync them first to minimize healing overhead.
    try {
      await syncClients(userId);
      await syncBooks(userId);
    } catch (e) {
      print('Sync Error (Base Entities): $e');
      // Continue anyway, Healing might fix specific missing items
    }

    // 2. Sync Headers & Independent Transactions
    // Sales, Purchases, Expenses, Returns (Headers)
    try {
      await syncInvoices(userId);
    } catch (e) {
      print('Sync Error (Headers): $e');
    }

    // 3. Sync Details (Children)
    // Items that depend on Headers or Books
    try {
      await syncInvoiceItems(userId);
    } catch (e) {
      print('Sync Error (Items): $e');
    }
  }

  // --- Helper Methods ---

  Future<void> syncClients(String userId) async {
    // Customers
    await _syncWithHealing<Customer, CustomersCompanion>(
      table: _db.customers,
      tableName: 'customers',
      userId: userId,
      updateLocal: (id) =>
          _db.customers.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) => const CustomersCompanion(isSynced: Value(true)),
    );
    // Suppliers
    await _syncWithHealing<Supplier, SuppliersCompanion>(
      table: _db.suppliers,
      tableName: 'suppliers',
      userId: userId,
      updateLocal: (id) =>
          _db.suppliers.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) => const SuppliersCompanion(isSynced: Value(true)),
    );
  }

  Future<void> syncBooks(String userId) async {
    await _syncWithHealing<Book, BooksCompanion>(
      table: _db.books,
      tableName: 'books',
      userId: userId,
      updateLocal: (id) => _db.books.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) => const BooksCompanion(isSynced: Value(true)),
    );
  }

  Future<void> syncInvoices(String userId) async {
    // Sales (Links to Customers)
    await _syncWithHealing<Sale, SalesCompanion>(
      table: _db.sales,
      tableName: 'sales',
      userId: userId,
      updateLocal: (id) => _db.sales.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) => const SalesCompanion(isSynced: Value(true)),
    );

    // Purchase Invoices (Links to Suppliers)
    await _syncWithHealing<PurchaseInvoice, PurchaseInvoicesCompanion>(
      table: _db.purchaseInvoices,
      tableName: 'purchase_invoices',
      userId: userId,
      updateLocal: (id) =>
          _db.purchaseInvoices.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) =>
          const PurchaseInvoicesCompanion(isSynced: Value(true)),
    );

    // Return Invoices (Supplier Returns)
    await _syncWithHealing<ReturnInvoice, ReturnInvoicesCompanion>(
      table: _db.returnInvoices,
      tableName: 'return_invoices',
      userId: userId,
      updateLocal: (id) =>
          _db.returnInvoices.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) =>
          const ReturnInvoicesCompanion(isSynced: Value(true)),
    );

    // Sales Returns (Customer Returns - acts as item linking to Book)
    await _syncWithHealing<SalesReturn, SalesReturnsCompanion>(
      table: _db.salesReturns,
      tableName: 'sales_returns',
      userId: userId,
      updateLocal: (id) =>
          _db.salesReturns.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) =>
          const SalesReturnsCompanion(isSynced: Value(true)),
    );

    // Expenses
    await _syncWithHealing<Expense, ExpensesCompanion>(
      table: _db.expenses,
      tableName: 'expenses',
      userId: userId,
      updateLocal: (id) => _db.expenses.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) => const ExpensesCompanion(isSynced: Value(true)),
    );
  }

  Future<void> syncInvoiceItems(String userId) async {
    // Sale Items (Links to Sale and Book)
    await _syncWithHealing<SaleItem, SaleItemsCompanion>(
      table: _db.saleItems,
      tableName: 'sale_items',
      userId: userId,
      updateLocal: (id) =>
          _db.saleItems.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) => const SaleItemsCompanion(isSynced: Value(true)),
    );

    // Purchase Items (Links to PurchaseInvoice and Book)
    await _syncWithHealing<PurchaseItem, PurchaseItemsCompanion>(
      table: _db.purchaseItems,
      tableName: 'purchase_items',
      userId: userId,
      updateLocal: (id) =>
          _db.purchaseItems.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) =>
          const PurchaseItemsCompanion(isSynced: Value(true)),
    );

    // Return Items (Links to ReturnInvoice and Book)
    await _syncWithHealing<ReturnItem, ReturnItemsCompanion>(
      table: _db.returnItems,
      tableName: 'return_items',
      userId: userId,
      updateLocal: (id) =>
          _db.returnItems.update()..where((t) => t.id.equals(id)),
      createCompanion: (id) =>
          const ReturnItemsCompanion(isSynced: Value(true)),
    );
  }

  /// Unified sync method with "Self-Healing" capabilities
  /// Checks for FK violations and attempts to force-sync parent records
  Future<void> _syncWithHealing<
    TData extends DataClass,
    TCompanion extends UpdateCompanion<TData>
  >({
    required TableInfo<Table, TData> table,
    required String tableName,
    required String userId,
    required UpdateStatement<Table, TData> Function(String id) updateLocal,
    required TCompanion Function(String id) createCompanion,
  }) async {
    while (true) {
      final rows =
          await (_db.select(table)
                ..where((tbl) => (tbl as dynamic).isSynced.equals(false))
                ..limit(_batchSize))
              .get();

      if (rows.isEmpty) {
        break;
      }

      for (final row in rows) {
        final json = row.toJson(serializer: const _SupabaseJsonSerializer());
        final data = _prepareData(json, userId);
        final id = (row as dynamic).id as String;

        try {
          await _supabase.from(tableName).upsert(data);
          // Update local status
          await updateLocal(id).write(createCompanion(id));
        } on PostgrestException catch (e) {
          // Self-Healing Logic for Foreign Key Violations
          if (e.code == '23503') {
            try {
              bool healed = false;

              // 1. Check for Book dependency
              if (data.containsKey('book_id')) {
                await _forceSyncBook(data['book_id'], userId);
                healed = true;
              }

              // 2. Check for Customer dependency
              if (data.containsKey('customer_id')) {
                await _forceSyncCustomer(data['customer_id'], userId);
                healed = true;
              }

              // 3. Check for Supplier dependency
              if (data.containsKey('supplier_id')) {
                await _forceSyncSupplier(data['supplier_id'], userId);
                healed = true;
              }

              // 4. Check for Parent Invoice dependency (if available in future tables)
              // (e.g. sale_id, invoice_id logic can be added here if we need to force sync the header)

              if (healed) {
                // Retry Sync
                await _supabase.from(tableName).upsert(data);
                // Update local status on success
                await updateLocal(id).write(createCompanion(id));
              } else {
                print(
                  'Healing failed: No recognizible FK found to heal for $tableName',
                );
              }
            } catch (retryError) {
              print('Healing Attempt Failed: $retryError');
            }
          } else {
            print('Error syncing $tableName item: $e');
          }
        } catch (e) {
          print('Error syncing $tableName item: $e');
          if (e.toString().contains('JWT') || e.toString().contains('auth')) {
            rethrow;
          }
        }
      }

      if (rows.length < _batchSize) {
        break;
      }
    }
  }

  Future<void> _forceSyncBook(String? bookId, String userId) async {
    if (bookId == null) return;
    final record = await (_db.select(
      _db.books,
    )..where((t) => t.id.equals(bookId))).getSingleOrNull();

    if (record != null) {
      final json = record.toJson(serializer: const _SupabaseJsonSerializer());
      final data = _prepareData(json, userId);
      await _supabase.from('books').upsert(data);
    }
  }

  Future<void> _forceSyncCustomer(String? customerId, String userId) async {
    if (customerId == null) return;
    final record = await (_db.select(
      _db.customers,
    )..where((t) => t.id.equals(customerId))).getSingleOrNull();

    if (record != null) {
      final json = record.toJson(serializer: const _SupabaseJsonSerializer());
      final data = _prepareData(json, userId);
      await _supabase.from('customers').upsert(data);
    }
  }

  Future<void> _forceSyncSupplier(String? supplierId, String userId) async {
    if (supplierId == null) return;
    final record = await (_db.select(
      _db.suppliers,
    )..where((t) => t.id.equals(supplierId))).getSingleOrNull();

    if (record != null) {
      final json = record.toJson(serializer: const _SupabaseJsonSerializer());
      final data = _prepareData(json, userId);
      await _supabase.from('suppliers').upsert(data);
    }
  }

  Map<String, dynamic> _prepareData(Map<String, dynamic> json, String userId) {
    final newMap = <String, dynamic>{};
    json.forEach((key, value) {
      final snakeKey = _camelToSnake(key);
      // Exclude is_synced from the payload sent to Supabase
      if (snakeKey != 'is_synced') {
        newMap[snakeKey] = value;
      }
    });
    // Overwrite library_id with the authenticated User ID
    newMap['library_id'] = userId;
    return newMap;
  }

  String _camelToSnake(String input) {
    return input.replaceAllMapped(RegExp(r'[A-Z]'), (match) {
      return '_${match.group(0)!.toLowerCase()}';
    });
  }

  Future<void> restoreData() async {
    final user = _supabase.auth.currentUser;
    if (user == null) throw Exception('User not authenticated');

    // 1. Customers
    try {
      await _pullTable(
        'customers',
        _db.customers,
        (row) => CustomersCompanion.insert(
          id: Value(row['id'] as String),
          name: row['name'] as String,
          phone: Value(row['phone'] as String?),
          balance: Value((row['balance'] as num?)?.toDouble() ?? 0.0),
          lastUpdated:
              DateTime.tryParse(row['last_updated'] as String? ?? '') ??
              DateTime.now(),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Customers): $e');
    }

    // 2. Suppliers
    try {
      await _pullTable(
        'suppliers',
        _db.suppliers,
        (row) => SuppliersCompanion.insert(
          id: Value(row['id'] as String),
          name: row['name'] as String,
          phone: Value(row['phone'] as String?),
          address: Value(row['address'] as String?),
          balance: Value((row['balance'] as num?)?.toDouble() ?? 0.0),
          lastUpdated:
              DateTime.tryParse(row['last_updated'] as String? ?? '') ??
              DateTime.now(),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Suppliers): $e');
    }

    // 3. Books
    try {
      await _pullTable(
        'books',
        _db.books,
        (row) => BooksCompanion.insert(
          id: Value(row['id'] as String),
          name: row['name'] as String,
          currentStock: (row['current_stock'] as num?)?.toInt() ?? 0,
          costPrice: (row['cost_price'] as num?)?.toDouble() ?? 0.0,
          sellPrice: (row['sell_price'] as num?)?.toDouble() ?? 0.0,
          minLimit: (row['min_limit'] as num?)?.toInt() ?? 5,
          publisher: Value(row['publisher'] as String?),
          subject: Value(row['subject'] as String?),
          grade: Value(row['grade'] as String?),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Books): $e');
    }

    // 4. Sales
    try {
      await _pullTable(
        'sales',
        _db.sales,
        (row) => SalesCompanion.insert(
          id: Value(row['id'] as String),
          customerId: Value(row['customer_id'] as String?),
          saleDate: DateTime.parse(row['sale_date'] as String),
          paymentType: row['payment_type'] as String,
          totalAmount: (row['total_amount'] as num).toDouble(),
          discountValue: (row['discount_value'] as num).toDouble(),
          paidAmount: (row['paid_amount'] as num).toDouble(),
          remainingAmount: (row['remaining_amount'] as num).toDouble(),
          totalProfit: (row['total_profit'] as num).toDouble(),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Sales): $e');
    }

    // 5. Purchase Invoices
    try {
      await _pullTable(
        'purchase_invoices',
        _db.purchaseInvoices,
        (row) => PurchaseInvoicesCompanion.insert(
          id: Value(row['id'] as String),
          supplierId: row['supplier_id'] as String,
          invoiceDate: DateTime.parse(row['invoice_date'] as String),
          createdAt: DateTime.parse(row['created_at'] as String),
          totalBeforeDiscount: (row['total_before_discount'] as num).toDouble(),
          finalTotal: (row['final_total'] as num).toDouble(),
          discountValue: Value((row['discount_value'] as num?)?.toDouble()),
          paidAmount: Value((row['paid_amount'] as num?)?.toDouble()),
          invoiceImagePath: Value(row['invoice_image_path'] as String?),
          status: Value(row['status'] as String? ?? 'received'),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Purchase Invoices): $e');
    }

    // 6. Return Invoices
    try {
      await _pullTable(
        'return_invoices',
        _db.returnInvoices,
        (row) => ReturnInvoicesCompanion.insert(
          id: Value(row['id'] as String),
          supplierId: row['supplier_id'] as String,
          returnDate: DateTime.parse(row['return_date'] as String),
          totalAmount: (row['total_amount'] as num).toDouble(),
          finalAmount: (row['final_amount'] as num).toDouble(),
          discountPercentage: Value(
            (row['discount_percentage'] as num?)?.toDouble() ?? 0.0,
          ),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Return Invoices): $e');
    }

    // 7. Sales Returns
    try {
      await _pullTable(
        'sales_returns',
        _db.salesReturns,
        (row) => SalesReturnsCompanion.insert(
          id: Value(row['id'] as String),
          bookId: row['book_id'] as String,
          quantity: (row['quantity'] as num).toInt(),
          refundAmount: (row['refund_amount'] as num).toDouble(),
          returnDate: DateTime.parse(row['return_date'] as String),
          reason: Value(row['reason'] as String?),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Sales Returns): $e');
    }

    // 8. Expenses
    try {
      await _pullTable(
        'expenses',
        _db.expenses,
        (row) => ExpensesCompanion.insert(
          id: Value(row['id'] as String),
          title: row['title'] as String,
          category: row['category'] as String,
          amount: (row['amount'] as num).toDouble(),
          date: DateTime.parse(row['date'] as String),
          userNotes: Value(row['user_notes'] as String?),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Expenses): $e');
    }

    // 9. Sale Items
    try {
      await _pullTable(
        'sale_items',
        _db.saleItems,
        (row) => SaleItemsCompanion.insert(
          id: Value(row['id'] as String),
          saleId: row['sale_id'] as String,
          bookId: row['book_id'] as String,
          quantity: (row['quantity'] as num).toInt(),
          unitPrice: (row['unit_price'] as num).toDouble(),
          unitCostAtSale: (row['unit_cost_at_sale'] as num).toDouble(),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Sale Items): $e');
    }

    // 10. Purchase Items
    try {
      await _pullTable(
        'purchase_items',
        _db.purchaseItems,
        (row) => PurchaseItemsCompanion.insert(
          id: Value(row['id'] as String),
          invoiceId: row['invoice_id'] as String,
          bookId: row['book_id'] as String,
          quantity: (row['quantity'] as num).toInt(),
          unitCost: (row['unit_cost'] as num).toDouble(),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Purchase Items): $e');
    }

    // 11. Return Items
    try {
      await _pullTable(
        'return_items',
        _db.returnItems,
        (row) => ReturnItemsCompanion.insert(
          id: Value(row['id'] as String),
          returnId: row['return_id'] as String,
          bookId: row['book_id'] as String,
          quantity: (row['quantity'] as num).toInt(),
          unitCostAtReturn: (row['unit_cost_at_return'] as num).toDouble(),
          isSynced: const Value(true),
        ),
      );
    } catch (e) {
      print('Restore Error (Return Items): $e');
    }

    // Note: Transactions table does not exist in local schema (it's likely derived data),
    // and was thus omitted. Only real tables were restored.
  }

  Future<void> _pullTable<T extends Table, D extends DataClass>(
    String tableName,
    TableInfo<T, D> table,
    UpdateCompanion<D> Function(Map<String, dynamic>) mapper,
  ) async {
    try {
      final rows = await _supabase.from(tableName).select();
      if (rows.isEmpty) return;

      final companions = rows.map((row) => mapper(row)).toList();

      await _db.batch((batch) {
        batch.insertAll(table, companions, mode: InsertMode.insertOrReplace);
      });
    } catch (e) {
      print('Restore Error ($tableName): $e');
      rethrow;
    }
  }
}
