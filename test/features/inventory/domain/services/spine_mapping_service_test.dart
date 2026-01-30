import 'package:flutter_test/flutter_test.dart';
import 'package:librarymanager/features/inventory/domain/models/book_search_query.dart';
import 'package:librarymanager/features/inventory/domain/services/spine_mapping_service.dart';

void main() {
  late SpineMappingService service;

  setUp(() {
    service = SpineMappingService();
  });

  group('SpineMappingService', () {
    test('Standard Arabic: Al-Adwaa Arabic 1st Prep', () {
      final result = service.mapRawTextToQuery(
        'كتاب الأضواء اللغة العربية الصف الأول الإعدادي',
      );
      expect(
        result,
        const BookSearchQuery(
          publisher: 'الاضواء',
          subject: 'عربي',
          grade: '1ع',
        ),
      );
    });

    test('Standard English: Gem English First Prep', () {
      final result = service.mapRawTextToQuery('Gem English First Prep');
      expect(
        result,
        const BookSearchQuery(
          publisher: 'جيم',
          subject: 'انجليزي',
          grade: '1ع',
        ),
      );
    });

    test('Implicit Subject: Gem Second Secondary (Default to English)', () {
      final result = service.mapRawTextToQuery('Gem Second Secondary');
      expect(
        result,
        const BookSearchQuery(
          publisher: 'جيم',
          subject: 'انجليزي', // Implicit
          grade: '2ث',
        ),
      );
    });

    test('Implicit Subject: Newton (Physics)', () {
      final result = service.mapRawTextToQuery(
        'كتاب نيوتن للصف الثالث الثانوي',
      );
      expect(
        result,
        const BookSearchQuery(
          publisher: 'نيوتن',
          subject: 'فيزياء', // Implicit
          grade: '3ث',
        ),
      );
    });

    test('Social Studies Mapping: Social -> مواد', () {
      final result = service.mapRawTextToQuery('الدراسات الاجتماعية 4 ابتدائي');
      expect(result, const BookSearchQuery(subject: 'مواد', grade: '4ب'));
    });

    test('Term Extraction: Term 1 -> ج1', () {
      final result = service.mapRawTextToQuery(
        'المعاصر رياضيات 2 اعدادي الترم الاول',
      );
      expect(
        result,
        const BookSearchQuery(
          publisher: 'المعاصر',
          subject: 'رياضه',
          grade: '2ع',
          term: 'ج1',
        ),
      );
    });

    // This test covers the "normalization" of "أولى" if supported, or shows failure if strict "الاول" is needed.
    // I suspect it might fail based on my implementation, but it's a good test case for robustness.
    // If "أولى" is not supported, result.grade will be null.
    // Normalized "أولى" -> "اولي" (alef with hamza -> alef).
    test('Normalization and Alef handling: أولى إعدادي', () {
      // "أولى" -> "اولي"
      // My code checks "الاول". "اولي" != "الاول".
      // This test is expected to fail with current implementation unless "اولي" is added.
      // But let's run it.
      final result = service.mapRawTextToQuery(
        'كتاب الامتحان دراسات أولى إعدادي',
      );
      expect(
        result,
        const BookSearchQuery(
          publisher: 'الامتحان',
          subject: 'مواد',
          grade: '1ع',
        ),
      );
    });
  });
}
