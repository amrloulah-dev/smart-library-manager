class TextNormalizer {
  static const List<String> knownPublishers = [
    'التأسيس',
    'التاسيس', // CRITICAL FIX
    'التاسي',
    'سلاح التلميذ',
    'سلاح',
    'بيت باي بيت',
    'Bit By Bit',
    'ستيب اهيد',
    'قطر الندى',
    'قطر',
    'العمالقة',
    'المعاصر',
    'الامتحان',
    'الأضواء',
    'الاضواء',
    'الأبرار',
    'الشاطر',
    'الفائز',
    'المتميز',
    'السندباد',
    'المرشد',
    'الإمام',
    'الأستاذ',
    'ماندليف',
    'الوافي',
    'الكيان',
    'التفوق',
    'الوسام',
    'نيوتن',
    'جيم',
  ];

  static final List<String> knownSubjects = [
    'عربي',
    'لغة عربية',
    'رياضة',
    'حساب',
    'ماث',
    'علوم',
    'ساينس',
    'دراسات',
    'انجليزي',
    'دين',
    'حاسب',
  ];

  /// Legacy method wrapper for backward compatibility
  static String standardizeBookName(String rawText) {
    return reconstructBookName(rawText);
  }

  /// New "Deconstruct & Rebuild" logic
  static String reconstructBookName(String rawText) {
    if (rawText.isEmpty) return '';

    // --- PRIMARY BUSINESS RULES (Apply FIRST) ---
    // Fix "Mawad" -> "Derasat" immediately
    String text = rawText.replaceAll('مواد', 'دراسات');

    // --- Step A: Normalization ---
    // 1. Flatten Whitespace
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    // 2. Remove Invisible Characters
    text = text.replaceAll(RegExp(r'[\u200B-\u200D\uFEFF]'), '');
    // 3. Digit Conversion
    text = _convertDigits(text);

    // 4. Strict Normalization for Matching (Strip Arabic Chars)
    // This unifies Alif variants, Ta Marbuta/Ha, and Ya/Alif Maqsurah
    text = _stripArabicChars(text);

    // Variables to hold extracted parts
    String? publisher;
    String? subject;
    String? grade;
    String? term;

    // --- Step B: Extraction ---

    // 1. Extract Publisher
    for (final pub in knownPublishers) {
      final normalizedPub = _stripArabicChars(pub);
      if (text.contains(normalizedPub)) {
        publisher = pub; // Use Canonical Name
        // Remove found publisher to prevent re-matching or interference
        text = text.replaceFirst(normalizedPub, ' ').trim();
        break;
      }
    }

    // 2. Extract Grade (e.g., 3ب, 3 ب, 3ث)
    // Regex: (\d+)\s*([بعث])
    final gradeMatch = RegExp(r'(\d+)\s*([بعث])').firstMatch(text);
    if (gradeMatch != null) {
      // Format: "3ب"
      grade = '${gradeMatch.group(1)}${gradeMatch.group(2)}';
      // Remove from text
      text = text.replaceAll(gradeMatch.group(0)!, ' ').trim();
    }

    // 3. Extract Term (e.g., ج1, 1ج, ترم 1, ترم1)
    // Regex: (ج\d|\dج|ترم\s*\d)
    final termMatch = RegExp(r'(ج\s*\d|\d\s*ج|ترم\s*\d)').firstMatch(text);
    if (termMatch != null) {
      // Extract the digit to normalize to "ج1" or "ج2"
      final digitMatch = RegExp(r'\d').firstMatch(termMatch.group(0)!);
      if (digitMatch != null) {
        term = 'ج${digitMatch.group(0)}';
      }
      // Remove from text
      text = text.replaceAll(termMatch.group(0)!, ' ').trim();
    }

    // --- Step C: Subject Identification (The Survivor) ---
    // Whatever text remains is considered the subject
    subject = text.trim();

    // Try to normalize the extracted subject if it matches a known one
    for (final sub in knownSubjects) {
      final normalizedSub = _stripArabicChars(sub);
      if (subject!.contains(normalizedSub)) {
        if (sub == 'لغة عربية') {
          subject = 'عربي';
        } else if (sub == 'حساب') {
          subject = 'رياضة';
        } else {
          subject = sub; // Use canonical name
        }
        break;
      }
    }

    // --- Step D: Inference ---
    // If subject is empty (meaning raw text only had Publisher/Grade/Term), try to infer
    if ((subject!.isEmpty) &&
        (publisher == 'جيم' ||
            publisher == 'بيت باي بيت' ||
            publisher == 'ستيب اهيد')) {
      subject = 'انجليزي';
    }

    // --- Step E: Rebuild ---
    // Strict Order: Publisher Subject Grade Term
    final components = [publisher, subject, grade, term];
    // Filter out nulls and join with space
    return components.where((c) => c != null && c.isNotEmpty).join(' ');
  }

  static String _convertDigits(String input) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const latinDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String output = input;
    for (int i = 0; i < arabicDigits.length; i++) {
      output = output.replaceAll(arabicDigits[i], latinDigits[i]);
    }
    return output;
  }

  static String _stripArabicChars(String text) {
    if (text.isEmpty) return text;
    String normalized = text;
    // Replace Alef variations with bare Alef
    normalized = normalized.replaceAll(RegExp(r'[أإآ]'), 'ا');
    // Replace Ya variations (Alef Maqsurah) with Ya
    normalized = normalized.replaceAll('ى', 'ي');
    // Replace Ta Marbuta with Ha
    normalized = normalized.replaceAll('ة', 'ه');
    // Remove Tashkeel (Diacritics) - range \u064B-\u065F
    normalized = normalized.replaceAll(RegExp(r'[\u064B-\u065F]'), '');
    return normalized;
  }
}
