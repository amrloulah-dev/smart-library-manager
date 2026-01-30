import 'package:flutter_test/flutter_test.dart';
import 'package:librarymanager/features/reports/domain/services/business_intelligence_service.dart';
import 'package:librarymanager/core/database/daos/sales_dao.dart';
import 'package:librarymanager/core/database/daos/smart_settings_dao.dart';
import 'package:librarymanager/core/database/daos/books_dao.dart';
import 'package:librarymanager/core/database/app_database.dart';

// Stub classes that satisfy the constructor requirements
// These tests only use pure calculation methods that don't call the DAOs
class _StubSalesDao extends SalesDao {
  _StubSalesDao() : super(_StubDatabase());
}

class _StubSmartSettingsDao extends SmartSettingsDao {
  _StubSmartSettingsDao() : super(_StubDatabase());
}

class _StubBooksDao extends BooksDao {
  _StubBooksDao() : super(_StubDatabase());
}

class _StubDatabase extends AppDatabase {
  _StubDatabase() : super.forTesting();
}

void main() {
  late BusinessIntelligenceService service;

  setUp(() {
    service = BusinessIntelligenceService(
      _StubSalesDao(),
      _StubSmartSettingsDao(),
      _StubBooksDao(),
    );
  });

  group('BusinessIntelligenceService', () {
    test('calculateSalesVelocity - Standard', () {
      final result = service.calculateSalesVelocity(100, 10);
      expect(result, 10.0);
    });

    test('calculateSalesVelocity - Zero Period (Division by Zero)', () {
      final result = service.calculateSalesVelocity(100, 0);
      expect(result, 0.0);
    });

    test('predictStockoutDate - Standard', () {
      // 50 stock, 5/day -> 10 days
      final now = DateTime.now();
      final result = service.predictStockoutDate(50, 5.0);
      expect(result, isNotNull);
      final diff = result!.difference(now).inDays;
      expect(diff, closeTo(10, 1)); // Allow minor time difference
    });

    test('predictStockoutDate - Zero Velocity', () {
      final result = service.predictStockoutDate(50, 0.0);
      expect(result, isNull);
    });

    test('predictStockoutDate - Negative Velocity', () {
      final result = service.predictStockoutDate(50, -5.0);
      expect(result, isNull);
    });

    test('getReturnAlertLevel - Null', () {
      final result = service.getReturnAlertLevel(null);
      expect(result, AlertLevel.none);
    });

    test('getReturnAlertLevel - Expired', () {
      final pastDate = DateTime.now().subtract(const Duration(days: 1));
      final result = service.getReturnAlertLevel(pastDate);
      expect(result, AlertLevel.expired);
    });

    test('getReturnAlertLevel - Critical (< 14 days)', () {
      final futureDate = DateTime.now().add(const Duration(days: 10));
      final result = service.getReturnAlertLevel(futureDate);
      expect(result, AlertLevel.critical);
    });

    test('getReturnAlertLevel - Warning (< 30 days)', () {
      final futureDate = DateTime.now().add(const Duration(days: 20));
      final result = service.getReturnAlertLevel(futureDate);
      expect(result, AlertLevel.warning);
    });

    test('getReturnAlertLevel - Safe (> 30 days)', () {
      final futureDate = DateTime.now().add(const Duration(days: 40));
      final result = service.getReturnAlertLevel(futureDate);
      expect(result, AlertLevel.safe);
    });

    test('calculateSupplierScore - Standard', () {
      // 100 bought, 0 returned -> 5.0
      expect(service.calculateSupplierScore(100, 0), 5.0);
    });

    test('calculateSupplierScore - 20% Return', () {
      // 100 bought, 20 returned -> Rate 0.2 -> Penalty 1.0 -> Score 4.0
      expect(service.calculateSupplierScore(100, 20), 4.0);
    });

    test('calculateSupplierScore - 100% Return', () {
      // 100 bought, 100 returned -> Rate 1.0 -> Penalty 5.0 -> Score 0.0 -> Clamped 1.0
      expect(service.calculateSupplierScore(100, 100), 1.0);
    });

    test('calculateSupplierScore - Half Return', () {
      // 100 bought, 50 returned -> Rate 0.5 -> Penalty 2.5 -> Score 2.5
      expect(service.calculateSupplierScore(100, 50), 2.5);
    });

    test('calculateSupplierScore - Zero Purchases', () {
      expect(service.calculateSupplierScore(0, 0), 5.0);
    });
  });
}
