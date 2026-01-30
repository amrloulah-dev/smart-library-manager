import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/relations/domain/repositories/relations_repository.dart';

@LazySingleton(as: RelationsRepository)
class RelationsRepositoryImpl implements RelationsRepository {
  final AppDatabase _db;

  RelationsRepositoryImpl(this._db);

  @override
  Future<double> getTotalPaidToSuppliers() async {
    // FIX: Use Suppliers.totalPaid as the Single Source of Truth for all payments.
    // This value accumulates both Manual Payments and Invoice Payments (via SuppliersDao).
    // Avoiding Invoices table prevents double-counting.
    final query = _db.selectOnly(_db.suppliers)
      ..addColumns([_db.suppliers.totalPaid.sum()]);
    final result = await query.getSingleOrNull();

    return result?.read(_db.suppliers.totalPaid.sum()) ?? 0.0;
  }
}
