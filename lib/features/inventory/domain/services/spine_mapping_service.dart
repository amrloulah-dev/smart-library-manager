import 'package:injectable/injectable.dart';
import '../models/book_search_query.dart';

@lazySingleton
class SpineMappingService {
  BookSearchQuery mapRawTextToQuery(String rawText) {
    String processedText = _normalize(rawText);

    final String? publisher = _extractPublisher(processedText);
    String? subject = _extractSubject(processedText);
    final String? term = _extractTerm(processedText);

    // Remove term phrases to avoid "الترم الاول" matching Grade 1
    String textForGrade = processedText;
    final termPhrases = [
      'الفصل الدراسي الاول',
      'الترم الاول',
      'term 1',
      'جزء 1',
      'الفصل الدراسي الثاني',
      'الترم الثاني',
      'term 2',
      'جزء 2',
    ];
    for (final phrase in termPhrases) {
      textForGrade = textForGrade.replaceAll(phrase, '');
    }

    final String? grade = _extractGrade(textForGrade);
    // Note: 'part' logic derived from term logic in requirement examples:
    // "term 1" -> "ج1" which seems to be conflated with term in the requirement:
    // "الفصل الدراسي الاول" -> "ج1".
    // I will follow the accepted requirement: "term 1" -> `ج1`.
    // If explicit "part" is needed distinct from term, I will add it,
    // but the requirement "Step 5" maps term phrases to `ج1`/`ج2`.
    // Wait, the requirement says:
    // "الفصل الدراسي الاول" ... -> `ج1`
    // "جزء 1" -> part: "ج1" (from Phase 2.1 description, but let's stick to 2.2 detailed requirements).
    // In Phase 2.2 REQ: "الفصل الدراسي الاول" -> `ج1`.
    // So I will map this result to the `term` field or `part` field?
    // The model has both `term` and `part`.
    // Phase 2.1 said: "الفصل... -> term: ترم1", "جزء 1 -> part: ج1".
    // Phase 2.2 said: "الفصل... -> ج1".
    // I will assume for now that these map to the `grade` suffix or a specific field.
    // Actually, looking at the output example "1ع", "ج1" looks like part/term.
    // Let's use `term` field for "term" related stuff, and if the user wants `ج1` as the value, so be it.

    // However, looking closely at Phase 2.2 Req Step 5:
    // "الفصل الدراسي الاول" -> `ج1`
    // The field in model is `term` and `part`. I will assign this output to `part` if it looks like a part (juz'),
    // but the prompt calls it "Term/Part".
    // I will assign "ج1"/"ج2" to the `term` field to match the common semantic of "First Term".
    // Ideally it should be `term: '1'` or `part: '1'`.
    // Let's assume the user wants the string "ج1" stored in `term`.

    // Implicit Logic
    if (subject == null) {
      if (publisher == 'جيم' || publisher == 'بيت') {
        subject = 'انجليزي';
      } else if (publisher == 'الفائز') {
        subject = 'كمبيوتر';
      } else if (publisher == 'نيوتن') {
        subject = 'فيزياء';
      }
    }

    return BookSearchQuery(
      publisher: publisher,
      subject: subject,
      grade: grade,
      term: term,
      part:
          null, // "part" was requested in model but logic maps term phrases to "ج1". I will leave part null for now unless distinct "part 1" text is found.
    );
  }

  String _normalize(String text) {
    String normalized = text.toLowerCase();

    // Normalize Alef
    normalized = normalized.replaceAll(RegExp(r'[أإآ]'), 'ا');
    // Normalize Yeh
    normalized = normalized.replaceAll('ى', 'ي');
    // Normalize Teh Marbuta
    normalized = normalized.replaceAll('ة', 'ه');

    // Remove special characters but keep Arabic and English letters and numbers and spaces
    // Ranges: \u0600-\u06FF (Arabic), a-z, 0-9
    // actually we need to preserve spaces.
    normalized = normalized.replaceAll(RegExp(r'[^\u0600-\u06FFa-z0-9\s]'), '');

    return normalized;
  }

  String? _extractPublisher(String text) {
    if (text.contains('الاضواء') || text.contains('aladwaa')) return 'الاضواء';
    if (text.contains('سلاح') || text.contains('selah')) {
      return 'سلاح'; // Covers "سلاح التلميذ" as it contains "سلاح"
    }
    if (text.contains('المعاصر') || text.contains('moasser')) return 'المعاصر';
    if (text.contains('جيم') || text.contains('gem')) return 'جيم';
    if (text.contains('بيت') || text.contains('bit')) return 'بيت';
    if (text.contains('الامتحان')) return 'الامتحان';
    if (text.contains('الفائز')) return 'الفائز';
    if (text.contains('نيوتن')) return 'نيوتن';
    return null;
  }

  String? _extractSubject(String text) {
    if (text.contains('عربي') || text.contains('لغه عربيه')) return 'عربي';
    if (text.contains('انجليزي') || text.contains('english')) return 'انجليزي';
    if (text.contains('رياضيات') ||
        text.contains('رياضه') ||
        text.contains('math')) {
      return 'رياضه';
    }
    if (text.contains('علوم') || text.contains('science')) return 'علوم';
    if (text.contains('دراسات') || text.contains('social')) return 'مواد';
    if (text.contains('فيزياء') || text.contains('physics')) return 'فيزياء';
    if (text.contains('كيمياء') || text.contains('chemistry')) return 'كيمياء';
    if (text.contains('احياء') || text.contains('biology')) return 'احياء';
    if (text.contains('كمبيوتر') || text.contains('computer')) return 'كمبيوتر';
    return null;
  }

  String? _extractGrade(String text) {
    // Numbers
    String? number;
    if (text.contains('الاول') ||
        text.contains('first') ||
        text.contains(' 1 ') ||
        text.contains('اولي')) {
      number =
          '1'; // Space padding for digits to avoid partial matches like in '10'
    } else if (text.contains('الثاني') ||
        text.contains('second') ||
        text.contains(' 2 '))
      number = '2';
    else if (text.contains('الثالث') ||
        text.contains('third') ||
        text.contains(' 3 '))
      number = '3';
    else if (text.contains('الرابع') || text.contains(' 4 '))
      number = '4';
    else if (text.contains('الخامس') || text.contains(' 5 '))
      number = '5';
    else if (text.contains('السادس') || text.contains(' 6 '))
      number = '6';

    // Fallback for non-padded numbers if needed, or stricter checks.
    // Regex might be better for "1": \b1\b
    if (number == null) {
      if (RegExp(r'\b1\b').hasMatch(text)) number = '1';
      if (RegExp(r'\b2\b').hasMatch(text)) number = '2';
      if (RegExp(r'\b3\b').hasMatch(text)) number = '3';
      if (RegExp(r'\b4\b').hasMatch(text)) number = '4';
      if (RegExp(r'\b5\b').hasMatch(text)) number = '5';
      if (RegExp(r'\b6\b').hasMatch(text)) number = '6';
    }

    if (number == null) return null;

    // Stages
    String? stage;
    if (text.contains('ابتدائي') || text.contains('primary')) {
      stage = 'ب'; // 'ب' check might be too aggressive? No, raw text.
    }
    // "6ب" in requirements implies 6 + b.
    // But text input is "السادس الابتدائي".

    if (stage == null) {
      if (text.contains('اعدادي') || text.contains('prep')) stage = 'ع';
    }
    if (stage == null) {
      if (text.contains('ثانوي') || text.contains('sec')) stage = 'ث';
    }

    if (stage != null) {
      return '$number$stage';
    }
    return null;
  }

  String? _extractTerm(String text) {
    if (text.contains('الفصل الدراسي الاول') ||
        text.contains('الترم الاول') ||
        text.contains('term 1') ||
        text.contains('جزء 1')) {
      return 'ج1';
    }
    if (text.contains('الفصل الدراسي الثاني') ||
        text.contains('الترم الثاني') ||
        text.contains('term 2') ||
        text.contains('جزء 2')) {
      return 'ج2';
    }
    return null;
  }
}
