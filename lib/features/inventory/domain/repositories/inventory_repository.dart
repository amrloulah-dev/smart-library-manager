import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/features/inventory/domain/models/book_search_query.dart';
import 'package:librarymanager/features/invoices/domain/models/scanned_item_model.dart';
import 'package:librarymanager/features/reports/domain/models/item_history_model.dart';
import 'package:librarymanager/features/inventory/domain/models/inventory_filter.dart';

abstract class InventoryRepository {
  Future<void> createPurchaseInvoice(
    String supplierId,
    List<ScannedItemModel> items,
    double discount,
    DateTime date, {
    double paidAmount = 0.0,
  });

  /// Deletes a purchase invoice and reverts all its effects (Inventory & Supplier Balance)
  Future<void> deletePurchaseInvoice(String invoiceId);
  Stream<List<Book>> streamAllBooks();
  Stream<List<Supplier>> streamAllSuppliers();

  Future<int> insertBook(BooksCompanion book);
  Future<int> insertSupplier(SuppliersCompanion supplier);

  Future<void> addSupplier({
    required String name,
    String? phone,
    String? address,
    int? leadTime,
    bool isReturnable = true,
    int returnPolicyDays = 90,
  });

  Future<List<Book>> findBookByAttributes(BookSearchQuery query);
  Future<Book?> findBookByName(String name);
  Future<Book?> getBookById(String bookId);

  Future<void> updateBookStock(String bookId, int quantityChange);
  Future<void> updateSupplierBalance(String id, double amount);
  Future<void> processSupplierTransaction(
    String id,
    double amount, {
    bool isPayment = true,
  });

  Future<void> processSupplierReturn(
    String supplierId,
    Map<Book, int> itemsToReturn,
    double discountPercentage,
  );
  Future<List<Book>> getLowStockBooks();

  // Customer Management
  Future<Customer> createCustomer(CustomersCompanion customer);
  Future<List<Customer>> searchCustomers(String query);

  // History & Insights
  Future<ItemHistoryResult> getItemHistory(String bookId);

  Future<List<Book>> getBooksPaginated({
    int limit = 20,
    int offset = 0,
    String? searchQuery,
    InventoryFilter? filter,
  });

  // Smart Restocking Settings
  Future<DateTime?> getSeasonEndDate();
  Future<void> setSeasonEndDate(DateTime date);
  Future<int?> getTargetForGrade(String grade);
  Future<void> setTargetForGrade(String grade, int count);
  Future<void> deleteBook(String bookId);
  Future<void> updateBookDetails(BooksCompanion book);

  Future<Map<String, int>> getAllGradeTargets();
  Future<void> repairBooks();
}
