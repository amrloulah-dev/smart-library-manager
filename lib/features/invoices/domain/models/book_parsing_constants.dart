class BookParsingConstants {
  BookParsingConstants._();

  // --- Pricing Configuration ---
  static const double defaultDivisor = 0.82;
  static const double selahElTelmeezDivisor = 0.825;

  /// Map of publishers with a non-standard divisor (e.g., 0.80).
  /// Keys MUST match the official standardized publisher names used in output.
  static const Map<String, double> publisherDivisors = {
    'قطر الندى': 0.80,
    'التاسيس': 0.80, // Explicitly No Hamza as requested
    'التأسيس': 0.80, // Safety fallback
    'الأبرار': 0.80,
    'الشاطر': 0.80,
    'ستيب اهيد': 0.80,
    'الفائز': 0.80,
    'نيوتن': 0.80,
    'المتميز': 0.80,
    'السندباد': 0.80,
    'المرشد': 0.80,
    'الإمام': 0.80,
    'الأستاذ': 0.80,
    'ماندليف': 0.80,
    'العمالقة': 0.80,
    'الوافي': 0.80,
    'الكيان': 0.80,
    'التفوق': 0.80,
    'الوسام': 0.80,
  };

  /// Explicit Subject Aliases to fix OCR errors and normalize names.
  /// Key: Alias (what we find in text), Value: Official Name (what we save).
  static const Map<String, String> subjectAliases = {
    // Math
    'حساب': 'رياضة',
    'رياضيات': 'رياضة',
    'ماث': 'رياضة',
    'رياضه': 'رياضة',
    'رياضة': 'رياضة',

    // Social Studies / Materials
    'مواد': 'دراسات',
    'مواده': 'دراسات',
    'دراسات': 'دراسات',

    // English
    'انكليزي': 'انجليزي',
    'انجليزى': 'انجليزي',
    'English': 'انجليزي',
    'انجليزي': 'انجليزي',

    // Arabic
    'عربى': 'عربي',
    'لغه عربيه': 'عربي',
    'لغة عربية': 'عربي',
    'عربي': 'عربي',

    // Science
    'ساينس': 'علوم',
    'علوم': 'علوم',

    // French
    'فرنساوي': 'فرنساوي',

    // German
    'الماني': 'الماني',

    // Italian
    'ايطالي': 'ايطالي',

    // Religion
    'دين': 'دين',
  };

  // Publisher Aliases to help normalization (Legacy/Helpers)
  static const Map<String, String> publisherAliases = {
    // Al-Ta'sis
    'التأسيس': 'التاسيس',
    'التأسيس السليم': 'التاسيس',
    'التاسي': 'التاسيس',
    'التاسيس': 'التاسيس',
    'التاسيس السليم': 'التاسيس',

    // English Publishers
    'جيم': 'جيم',
    'gem': 'جيم',
    'bit by bit': 'بيت باي بيت',
    'بيت باي بيت': 'بيت باي بيت',
    'ستيب اهيد': 'ستيب اهيد',
    'step ahead': 'ستيب اهيد',

    // Others
    'قطر': 'قطر الندى',
    'سلاح': 'سلاح التلميذ',
    'اضواء': 'الاضواء',
    'معاصر': 'المعاصر',
    'امتحان': 'الامتحان',
    'الاستاذ': 'الأستاذ',
    'الامام': 'الإمام',
    'الابرار': 'الأبرار',
  };

  // Regex Patterns

  /// Detects grade patterns like '3ب', '3 ب', '3ع'.
  static final RegExp gradePattern = RegExp(r'\d+\s*[بعث]');

  /// Detects term patterns like 'ج1', 'ج 2'.
  static final RegExp termPattern = RegExp(r'ج\s*\d+');

  /// Detects words ending in 'ه' followed by a grade char (e.g., 'دراساته ب').
  /// This is often an OCR error for 'دراسات 5 ب'.
  static final RegExp hehSuffixForGradeFivePattern = RegExp(
    r'(\w+)ه\s*([بعث])',
  );
}
