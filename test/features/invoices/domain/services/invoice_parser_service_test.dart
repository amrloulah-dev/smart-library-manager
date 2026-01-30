import 'package:flutter_test/flutter_test.dart';
import 'package:librarymanager/features/invoices/domain/models/scanned_item_model.dart';
import 'package:librarymanager/features/invoices/domain/services/invoice_parser_service.dart';

void main() {
  late InvoiceParserService parser;

  setUp(() {
    parser = InvoiceParserService();
  });

  group('InvoiceParserService', () {
    test('parses standard line with code correctly', () {
      final result = parser.parseLine(
        '001010002 Al-Adwaa Arabic 5 130.40 652.00',
      );
      expect(
        result,
        const ScannedItemModel(
          code: '001010002',
          name: 'Al-Adwaa Arabic',
          quantity: 5,
          price: 130.40,
        ),
      );
    });

    test('parses line without code correctly', () {
      final result = parser.parseLine('Al-Adwaa Arabic 5 130.40 652.00');
      expect(
        result,
        const ScannedItemModel(
          code: null,
          name: 'Al-Adwaa Arabic',
          quantity: 5,
          price: 130.40,
        ),
      );
    });

    test('returns null for header line', () {
      final result = parser.parseLine('Item Name Quantity Price Total');
      expect(result, isNull);
    });

    test('returns null for random text', () {
      final result = parser.parseLine('Some Random text here');
      expect(result, isNull);
    });

    test('parses line with extra spaces correctly', () {
      final result = parser.parseLine('  Trimmed Name   5 10.0');
      expect(
        result,
        const ScannedItemModel(
          code: null,
          name: 'Trimmed Name',
          quantity: 5,
          price: 10.0,
        ),
      );
    });

    test('parses line with complex name containing spaces', () {
      final result = parser.parseLine(
        '123 Very Long Product Name With Spaces 10 99.99 999.9',
      );
      expect(
        result,
        const ScannedItemModel(
          code: '123',
          name: 'Very Long Product Name With Spaces',
          quantity: 10,
          price: 99.99,
        ),
      );
    });

    test('parses line with decimal quantity (e.g. 5.00 -> 5)', () {
      final result = parser.parseLine('001 New Item 5.00 120.50 600.0');
      expect(
        result,
        const ScannedItemModel(
          code: '001',
          name: 'New Item',
          quantity: 5,
          price: 120.50,
        ),
      );
    });
  });
}
