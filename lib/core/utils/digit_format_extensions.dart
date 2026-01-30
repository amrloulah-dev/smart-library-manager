extension StringDigitExtensions on String {
  String get toEnglishDigits {
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    String result = this;
    for (int i = 0; i < arabic.length; i++) {
      result = result.replaceAll(arabic[i], english[i]);
    }
    return result;
  }
}

extension NumDigitExtensions on num {
  String get toEnglishString {
    return toString().toEnglishDigits;
  }

  String get toEnglishAsFixed0 {
    return toStringAsFixed(0).toEnglishDigits;
  }

  String get toEnglishAsFixed2 {
    return toStringAsFixed(2).toEnglishDigits;
  }
}
