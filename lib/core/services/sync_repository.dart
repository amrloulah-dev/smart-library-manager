import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';

@lazySingleton
class SyncRepository {
  final AppDatabase _db;
  final SupabaseClient _supabase;

  SyncRepository(this._db, this._supabase);

  Future<void> pushChanges() async {
    // 1. Check Connectivity
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return;
    }

    // 2. Check Authentication & Get User ID
    final user = _supabase.auth.currentUser;
    if (user == null) {
      return;
    }
    final userId = user.id;

    try {
      await _syncBooks(userId);
      await _syncSales(userId);
      // await _syncCustomers(userId);
      // await _syncSuppliers(userId);
      // ... Add other tables here
    } catch (e) {
      // Log error or handle it
    }
  }

  Future<void> _syncBooks(String userId) async {
    // 1. Select unsynced rows
    final unsyncedBooks = await (_db.select(
      _db.books,
    )..where((tbl) => tbl.isSynced.equals(false))).get();

    if (unsyncedBooks.isEmpty) return;

    // 2. Convert to JSON for Supabase (snake_case)
    final data = unsyncedBooks.map((book) {
      return {
        'id': book.id,
        'library_id': userId, // Ensure library_id is set to userId
        'name': book.name,
        'search_keywords': book.searchKeywords,
        'stage': book.stage,
        'grade': book.grade,
        'term': book.term,
        'subject': book.subject,
        'publisher': book.publisher,
        'edition_year': book.editionYear,
        'sell_price': book.sellPrice,
        'cost_price': book.costPrice,
        'current_stock': book.currentStock,
        'min_limit': book.minLimit,
        'return_deadline': book.returnDeadline?.toIso8601String(),
        'shelf_life_status': book.shelfLifeStatus,
        'total_sold_qty': book.totalSoldQty,
        'last_sale_date': book.lastSaleDate?.toIso8601String(),
        'last_supply_date': book.lastSupplyDate?.toIso8601String(),
        // Exclude isSynced
      };
    }).toList();

    // 3. Upsert to Supabase
    await _supabase.from('books').upsert(data);

    // 4. Mark isSynced = true locally
    await (_db.update(_db.books)
          ..where((tbl) => tbl.id.isIn(unsyncedBooks.map((b) => b.id))))
        .write(const BooksCompanion(isSynced: Value(true)));
  }

  Future<void> _syncSales(String userId) async {
    final unsyncedSales = await (_db.select(
      _db.sales,
    )..where((tbl) => tbl.isSynced.equals(false))).get();

    if (unsyncedSales.isEmpty) return;

    final data = unsyncedSales.map((sale) {
      return {
        'id': sale.id,
        'library_id': userId,
        'customer_id': sale.customerId,
        'sale_date': sale.saleDate.toIso8601String(),
        'payment_type': sale.paymentType,
        'total_amount': sale.totalAmount,
        'discount_value': sale.discountValue,
        'paid_amount': sale.paidAmount,
        'remaining_amount': sale.remainingAmount,
        'total_profit': sale.totalProfit,
      };
    }).toList();

    await _supabase.from('sales').upsert(data);

    await (_db.update(_db.sales)
          ..where((tbl) => tbl.id.isIn(unsyncedSales.map((s) => s.id))))
        .write(const SalesCompanion(isSynced: Value(true)));
  }
}
