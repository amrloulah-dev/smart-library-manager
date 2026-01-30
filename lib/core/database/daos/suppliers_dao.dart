import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';

part 'suppliers_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [Suppliers])
class SuppliersDao extends DatabaseAccessor<AppDatabase>
    with _$SuppliersDaoMixin {
  SuppliersDao(super.db);

  Stream<List<Supplier>> streamAllSuppliers() {
    return select(suppliers).watch();
  }

  Future<List<Supplier>> getAllSuppliers() {
    return select(suppliers).get();
  }

  Future<int> insertSupplier(SuppliersCompanion supplier) {
    return into(suppliers).insert(supplier);
  }

  Future<void> updateSupplierBalance(String id, double amount) {
    return transaction(() async {
      final supplier = await (select(
        suppliers,
      )..where((t) => t.id.equals(id))).getSingleOrNull();
      if (supplier != null) {
        final newBalance = supplier.balance + amount;
        await (update(suppliers)..where((t) => t.id.equals(id))).write(
          SuppliersCompanion(
            balance: Value(newBalance),
            isSynced: const Value(false),
          ),
        );
      }
    });
  }

  Future<void> processPaymentTransaction(
    String id,
    double amount, {
    bool isPayment = true,
  }) {
    return transaction(() async {
      final supplier = await (select(
        suppliers,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      if (supplier != null) {
        double newBalance = supplier.balance;
        double newTotalPaid = supplier.totalPaid;

        if (isPayment) {
          // Paying off debt: reduce balance, increase total paid
          newBalance -= amount;
          newTotalPaid += amount;
        } else {
          // Adding debt: increase balance (we owe more)
          newBalance += amount;
        }

        await (update(suppliers)..where((t) => t.id.equals(id))).write(
          SuppliersCompanion(
            balance: Value(newBalance),
            totalPaid: Value(newTotalPaid),
            isSynced: const Value(false),
          ),
        );
      }
    });
  }
}
