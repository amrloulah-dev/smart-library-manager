class PricingHelper {
  /// Calculates the selling price based on the publisher and grade rules.
  /// [cost] is the unit cost price.
  /// [bookName] is the normalized or raw book name string used to identify publisher and grade.
  static double calculateSellingPrice(double cost, String bookName) {
    if (cost <= 0) return 0.0;

    double divisor = 0.82; // Default Fallback

    // Normalize name for checking (though input might already be normalized, extra safety doesn't hurt)
    // We will check containment of specific arabic strings as per requirements.
    // Assuming bookName contains the publisher name.

    // 1. Identify Publisher & Apply Logic
    if (_containsAny(bookName, ['جيم', 'الامتحان', 'المعاصر', 'الأضواء'])) {
      // Group A
      divisor = 0.82;
    } else if (_containsAny(bookName, ['سلاح التلميذ'])) {
      // Group B
      divisor = 0.825;
    } else if (_containsAny(bookName, ['بيت باي بيت'])) {
      // Group C - Conditional on Grade
      if (_containsAny(bookName, ['1ب', '2ب', '3ب'])) {
        divisor = 0.80;
      } else {
        divisor = 0.82;
      }
    } else if (_containsAny(bookName, [
      'قطر الندى',
      'التأسيس',
      'الأبرار',
      'الشاطر',
      'ستيب اهيد',
      'الفائز',
      'نيوتن',
      'المتميز',
      'السندباد',
      'المرشد',
      'الإمام',
      'الأستاذ',
      'ماندليف',
      'العمالقة',
      'الوافي',
      'الكيان',
      'التفوق',
      'الوسام',
    ])) {
      // Group D
      divisor = 0.80;
    } else {
      // Fallback
      divisor = 0.82;
    }

    final sellingPrice = cost / divisor;

    // Return rounded to 2 decimal places
    return double.parse(sellingPrice.toStringAsFixed(2));
  }

  static bool _containsAny(String text, List<String> keywords) {
    for (final keyword in keywords) {
      if (text.contains(keyword)) {
        return true;
      }
    }
    return false;
  }
}
