import 'package:librarymanager/core/database/app_database.dart';

abstract class SalesRepository {
  Future<void> processSaleTransaction({
    required SalesCompanion sale,
    required List<SaleItemsCompanion> items,
    String? customerId,
    String? linkedReservationId,
  });

  Future<void> processExchange({
    required List<Book> returnedItems,
    required List<Book> newItems,
    double? finalNewItemPrice,
    double? finalReturnItemRefund,
  });

  Stream<List<Sale>> streamSalesHistory();
}
