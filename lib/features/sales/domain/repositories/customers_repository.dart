import 'package:librarymanager/core/database/app_database.dart';

abstract class CustomersRepository {
  Stream<List<Customer>> streamCustomers();
  Future<Customer> addCustomer(String name, String phone);
  Future<void> addPayment(String customerId, double amount);
  Future<void> deleteClient(String customerId);
}
