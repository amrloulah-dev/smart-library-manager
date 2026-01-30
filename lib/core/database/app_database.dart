import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'daos/books_dao.dart';
import 'daos/customers_dao.dart';
import 'daos/sales_dao.dart';
import 'daos/suppliers_dao.dart';
import 'daos/expenses_dao.dart';

import 'daos/smart_settings_dao.dart';

part 'app_database.g.dart';

// Books
class Books extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get searchKeywords => text().nullable()();
  TextColumn get stage => text().nullable()();
  TextColumn get grade => text().nullable()();
  TextColumn get term => text().nullable()();
  TextColumn get subject => text().nullable()();
  TextColumn get publisher => text().nullable()();
  IntColumn get editionYear => integer().nullable()();
  RealColumn get sellPrice => real()();
  RealColumn get costPrice => real()();
  IntColumn get currentStock => integer()();
  IntColumn get minLimit => integer()();
  DateTimeColumn get returnDeadline => dateTime().nullable()();
  TextColumn get shelfLifeStatus => text().nullable()();
  IntColumn get totalSoldQty => integer().withDefault(const Constant(0))();
  IntColumn get reservedQuantity => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastSaleDate => dateTime().nullable()();
  DateTimeColumn get lastSupplyDate => dateTime().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// Suppliers
class Suppliers extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  TextColumn get address => text().nullable()();
  IntColumn get leadTime => integer().nullable()();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  RealColumn get totalPaid => real().withDefault(const Constant(0.0))();
  RealColumn get aiScore => real().nullable()();
  DateTimeColumn get lastUpdated => dateTime()();
  BoolColumn get isReturnable => boolean().withDefault(const Constant(true))();
  IntColumn get returnPolicyDays => integer().withDefault(const Constant(90))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// PurchaseInvoices
class PurchaseInvoices extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get supplierId => text().references(Suppliers, #id)();
  DateTimeColumn get invoiceDate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get totalBeforeDiscount => real()();
  RealColumn get discountValue =>
      real().nullable()(); // ✅ Nullable for legacy records
  RealColumn get finalTotal => real()();
  RealColumn get paidAmount =>
      real().nullable()(); // ✅ Nullable for legacy records
  TextColumn get invoiceImagePath => text().nullable()();
  TextColumn get status =>
      text().withDefault(const Constant('received'))(); // 'ordered', 'received'
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// PurchaseItems
class PurchaseItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get invoiceId => text().references(PurchaseInvoices, #id)();
  TextColumn get bookId => text().references(Books, #id)();
  IntColumn get quantity => integer()();
  RealColumn get unitCost => real()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// Customers
class Customers extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  RealColumn get balance => real().withDefault(const Constant(0.0))();
  DateTimeColumn get lastUpdated => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// Sales
class Sales extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get customerId => text().nullable().references(Customers, #id)();
  DateTimeColumn get saleDate => dateTime()();
  TextColumn get paymentType => text()(); // 'Cash', 'Credit'
  RealColumn get totalAmount => real()();
  RealColumn get discountValue => real()();
  RealColumn get paidAmount => real()();
  RealColumn get remainingAmount => real()();
  RealColumn get totalProfit => real()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// SaleItems
class SaleItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get saleId => text().references(Sales, #id)();
  TextColumn get bookId => text().references(Books, #id)();
  IntColumn get quantity => integer()();
  RealColumn get unitPrice => real()();
  RealColumn get unitCostAtSale => real()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// Expenses
class Expenses extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get title => text()();
  TextColumn get category => text()(); // 'Electricity', 'Tea', etc.
  RealColumn get amount => real()();
  DateTimeColumn get date => dateTime()();
  TextColumn get userNotes => text().nullable()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// Reservations
class Reservations extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get customerName => text()();
  TextColumn get phone => text()();
  TextColumn get bookName => text()();
  TextColumn get bookId => text().nullable()();
  RealColumn get deposit => real()();
  TextColumn get status => text()(); // 'Pending', 'Arrived'
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// SalesReturns
class SalesReturns extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get bookId => text().references(Books, #id)();
  IntColumn get quantity => integer()();
  RealColumn get refundAmount => real()();
  TextColumn get reason => text().nullable()();
  DateTimeColumn get returnDate => dateTime()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// ReturnInvoices (Returns to Supplier)
class ReturnInvoices extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get supplierId => text().references(Suppliers, #id)();
  DateTimeColumn get returnDate => dateTime()();
  RealColumn get totalAmount => real()();
  RealColumn get discountPercentage =>
      real().withDefault(const Constant(0.0))();
  RealColumn get finalAmount => real()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// ReturnItems
class ReturnItems extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get libraryId => text().nullable()();
  TextColumn get returnId => text().references(ReturnInvoices, #id)();
  TextColumn get bookId => text().references(Books, #id)();
  IntColumn get quantity => integer()();
  RealColumn get unitCostAtReturn => real()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// GradeTargets
class GradeTargets extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get grade => text()();
  IntColumn get studentCount => integer()();
  TextColumn get libraryId => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {grade},
  ];
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

// AppSettings
class AppSettings extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  DateTimeColumn get seasonEndDate => dateTime().nullable()();
  IntColumn get defaultLeadTime => integer().withDefault(const Constant(3))();
  TextColumn get libraryId => text().nullable()();
  // License fields for offline validation
  TextColumn get licenseKey => text().nullable()();
  DateTimeColumn get licenseExpiryDate => dateTime().nullable()();
  TextColumn get licenseStatus =>
      text().withDefault(const Constant('inactive'))();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@lazySingleton
@DriftDatabase(
  tables: [
    Books,
    Suppliers,
    PurchaseInvoices,
    PurchaseItems,
    Customers,
    Sales,
    SaleItems,
    Expenses,
    Reservations,
    SalesReturns,
    ReturnInvoices,
    ReturnItems,
    GradeTargets,
    AppSettings,
  ],
  daos: [
    BooksDao,
    SuppliersDao,
    CustomersDao,
    SalesDao,
    ExpensesDao,
    SmartSettingsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// In-memory database for tests
  AppDatabase.forTesting() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 3) {
          await m.addColumn(suppliers, suppliers.totalPaid);
        }
        if (from < 4) {
          await m.createTable(gradeTargets);
          await m.createTable(appSettings);
          await m.addColumn(purchaseInvoices, purchaseInvoices.status);
        }
        if (from < 5) {
          await m.addColumn(books, books.lastSaleDate);
          await m.addColumn(books, books.lastSupplyDate);
          await m.addColumn(suppliers, suppliers.returnPolicyDays);
        }
        if (from < 6) {
          // Add isSynced column to all tables
          await m.addColumn(books, books.isSynced);
          await m.addColumn(suppliers, suppliers.isSynced);
          await m.addColumn(purchaseInvoices, purchaseInvoices.isSynced);
          await m.addColumn(purchaseItems, purchaseItems.isSynced);
          await m.addColumn(customers, customers.isSynced);
          await m.addColumn(sales, sales.isSynced);
          await m.addColumn(saleItems, saleItems.isSynced);
          await m.addColumn(expenses, expenses.isSynced);
          await m.addColumn(reservations, reservations.isSynced);
          await m.addColumn(salesReturns, salesReturns.isSynced);
          await m.addColumn(gradeTargets, gradeTargets.isSynced);
          await m.addColumn(appSettings, appSettings.isSynced);
        }
        if (from < 7) {
          // Add license columns to appSettings
          await m.addColumn(appSettings, appSettings.licenseKey);
          await m.addColumn(appSettings, appSettings.licenseExpiryDate);
          await m.addColumn(appSettings, appSettings.licenseStatus);
        }
        if (from < 8) {
          await m.createTable(returnInvoices);
          await m.createTable(returnItems);
        }
        if (from < 9) {
          await m.addColumn(books, books.reservedQuantity);
        }
        if (from < 10) {
          // isSynced columns were added in v6, so we just ensure consistency here
        }
      },
    );
  }
}
