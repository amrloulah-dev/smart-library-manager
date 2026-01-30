import 'package:drift/drift.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/database/daos/customers_dao.dart';
import 'package:librarymanager/features/sales/domain/repositories/customers_repository.dart';

@LazySingleton(as: CustomersRepository)
class CustomersRepositoryImpl implements CustomersRepository {
  final CustomersDao _customersDao;

  CustomersRepositoryImpl(this._customersDao);

  @override
  Stream<List<Customer>> streamCustomers() {
    return _customersDao.streamAllCustomers();
  }

  @override
  Future<Customer> addCustomer(String name, String phone) {
    return _customersDao.insertCustomer(
      CustomersCompanion(
        name: Value(name),
        phone: Value(phone),
        lastUpdated: Value(DateTime.now()),
      ),
    );
  }

  @override
  Future<void> addPayment(String customerId, double amount) {
    // Assuming adding payment reduces the debt (balance).
    // If balance is debt, payment reduces it.
    // So we subtract the amount.
    return _customersDao.updateCustomerBalance(customerId, -amount);
  }

  @override
  Future<void> deleteClient(String customerId) {
    return _customersDao.deleteCustomer(customerId);
  }
}
