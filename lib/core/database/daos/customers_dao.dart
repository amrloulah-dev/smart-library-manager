import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:uuid/uuid.dart';

part 'customers_dao.g.dart';

@lazySingleton
@DriftAccessor(tables: [Customers])
class CustomersDao extends DatabaseAccessor<AppDatabase>
    with _$CustomersDaoMixin {
  CustomersDao(super.db);

  Stream<List<Customer>> streamAllCustomers() {
    return select(customers).watch();
  }

  Future<Customer> insertCustomer(CustomersCompanion companion) async {
    final id = companion.id.present ? companion.id.value : const Uuid().v4();
    final effectiveCompanion = companion.copyWith(id: Value(id));

    await into(customers).insert(effectiveCompanion);
    return (select(customers)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<void> updateCustomerBalance(String id, double amount) {
    return transaction(() async {
      final customer = await (select(
        customers,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      if (customer != null) {
        final newBalance = customer.balance + amount;
        await (update(customers)..where((t) => t.id.equals(id))).write(
          CustomersCompanion(
            balance: Value(newBalance),
            isSynced: const Value(false),
          ),
        );
      }
    });
  }

  Future<void> deleteCustomer(String id) {
    return (delete(customers)..where((t) => t.id.equals(id))).go();
  }
}
