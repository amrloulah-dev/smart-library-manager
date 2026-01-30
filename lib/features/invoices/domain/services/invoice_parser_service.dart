import '../models/scanned_item_model.dart';
import '../models/book_parsing_constants.dart';

class InvoiceParserService {
  /// Parses a single line of text into a [ScannedItemModel].
  ///
  /// Expected formats:
  /// - `[Code] [Name] [Quantity] [Price] [Total]`
  /// - `[Name] [Quantity] [Price] [Total]`
  /// - `[Code] [Name] [Quantity] [Price]`
  /// - `[Name] [Quantity] [Price]`
  ScannedItemModel? parseLine(String line) {
    if (line.trim().isEmpty) {
      return null;
    }

    final parts = line.trim().split(RegExp(r'\s+'));
    if (parts.length < 3) {
      return null;
    }

    // Helper to parse double safely
    double? parseDouble(String? s) {
      if (s == null) return null;
      return double.tryParse(s);
    }

    // Attempt to identify the numeric tail of the line
    final lastPart = parts.last;
    final secondLastPart = parts[parts.length - 2];

    final lastNum = parseDouble(lastPart);
    final secondLastNum = parseDouble(secondLastPart);

    if (lastNum == null || secondLastNum == null) {
      return null;
    }

    int quantity;
    double costPrice;
    int nameEndIndex;

    // Check for a 3rd number from the end (Total)
    double? thirdLastNum;
    if (parts.length >= 3) {
      thirdLastNum = parseDouble(parts[parts.length - 3]);
    }

    if (thirdLastNum != null) {
      // Case: ... Qty Price Total
      quantity = thirdLastNum.toInt();
      costPrice = secondLastNum;
      nameEndIndex = parts.length - 3;
    } else {
      // Case: ... Qty Price
      quantity = secondLastNum.toInt();
      costPrice = lastNum;
      nameEndIndex = parts.length - 2;
    }

    if (nameEndIndex <= 0) return null;

    // Extract name parts
    final nameParts = parts.sublist(0, nameEndIndex);
    String? code;
    String rawName;

    // Check if the first part looks like a code (digits only)
    bool isFirstPartCode = RegExp(r'^\d+$').hasMatch(nameParts.first);

    if (isFirstPartCode && nameParts.length > 1) {
      code = nameParts.first;
      rawName = nameParts.sublist(1).join(' ');
    } else {
      rawName = nameParts.join(' ');
    }

    // --- SMART EXTRACTION PIPELINE ---
    // Returns a map with components for pricing logic
    final extractedData = _extractComponents(rawName);

    final standardizedName = extractedData['finalName'] ?? rawName;
    final publisher = extractedData['publisher'];
    final grade = extractedData['grade'];

    // --- PRICING LOGIC ---
    double sellPrice;
    double factor = BookParsingConstants.defaultDivisor;

    try {
      factor = _getPricingDivisor(publisher, grade);
      sellPrice = double.parse((costPrice / factor).toStringAsFixed(2));
    } catch (e) {
      sellPrice = costPrice / BookParsingConstants.defaultDivisor;
    }

    return ScannedItemModel(
      code: code,
      name: standardizedName,
      quantity: quantity,
      price: costPrice,
      sellPrice: sellPrice,
    );
  }

  /// Refactored to return components for pricing calculations
  /// Now includes strict Normalization First and Smart Subject Extraction.
  Map<String, String?> _extractComponents(String rawText) {
    if (rawText.trim().isEmpty) return {};

    // 1. Normalization First (Crucial Step: Unify Chars)
    String text = _normalizeInput(rawText);

    String? publisher;
    String? subject;
    String? grade;
    String? term;

    // 2. Identify and Remove Publisher
    // Al-Ta'sis Hard Override check on Normalized Text
    if (text.contains('تاسيس')) {
      publisher = 'التاسيس'; // Hard map to No-Hamza
      // Remove all variations to clear the buffer
      text = text
          .replaceAll('تاسيس', ' ')
          .replaceAll('تأسيس', ' ')
          .replaceAll('سليم', ' ');
    } else {
      // Standard Lookup - Sort keys by length first?
      // Constants map keys are not normalized, so we normalize them on fly or rely on partial match?
      // Actually BookParsingConstants.publisherAliases keys are now somewhat standard.
      // We will check if the text contains any of the keys.
      for (final entry in BookParsingConstants.publisherAliases.entries) {
        // Normalize the alias key just in case to match our text
        final normalizedKey = _normalizeInput(entry.key);
        if (text.contains(normalizedKey)) {
          publisher = entry.value;
          text = text.replaceAll(normalizedKey, ' ');
          // Also remove Original key in case input wasn't fully normalized same way
          text = text.replaceAll(entry.key, ' ');
          break;
        }
      }
    }

    // 3. Smart Subject Extraction (The Fix for 'Mawad', 'Hesab', etc.)
    for (final entry in BookParsingConstants.subjectAliases.entries) {
      final normalizedKey = _normalizeInput(entry.key);
      if (text.contains(normalizedKey)) {
        subject = entry.value; // Store OFFICIAL name (e.g. 'رياضة')
        text = text.replaceAll(normalizedKey, ' '); // Remove the alias
        text = text.replaceAll(entry.key, ' '); // Remove original too
        break;
      }
    }

    // 4. Extract Grade
    final gradeMatch = BookParsingConstants.gradePattern.firstMatch(text);
    if (gradeMatch != null) {
      grade = gradeMatch.group(0);
      text = text.replaceAll(grade!, ' ');
    }

    // 5. Extract Term
    final termMatch = BookParsingConstants.termPattern.firstMatch(text);
    if (termMatch != null) {
      term = termMatch.group(0);
      text = text.replaceAll(term!, ' ');
    }

    // Cleanup whitespace and garbage
    text = text.replaceAll(RegExp(r'\s+'), ' ').trim();

    // If subject is still null, whatever remains might be the subject
    if (subject == null && text.isNotEmpty) {
      // Clean up any remaining small garbage
      if (text.length > 2) {
        subject = text;
      }
    }

    // Final check: Special inference
    // If we have an English publisher but failed to find a subject, default to English.
    if (subject == null &&
        (publisher == 'جيم' ||
            publisher == 'بيت باي بيت' ||
            publisher == 'ستيب اهيد')) {
      subject = 'انجليزي';
    }

    // Rebuild Final Name for display/saving
    final parts = [publisher, subject, grade, term];
    final finalName = parts.where((s) => s != null && s.isNotEmpty).join(' ');

    return {
      'finalName': finalName,
      'publisher': publisher,
      'subject': subject,
      'grade': grade,
      'term': term,
    };
  }

  /// Normalizes Arabic text to standard unadorned characters.
  String _normalizeInput(String raw) {
    String text = raw;
    // Replace Alef forms with simple Alef
    text = text.replaceAll(RegExp(r'[أإآ]'), 'ا');
    // Replace Ta Marbuta with Ha
    text = text.replaceAll('ة', 'ه');
    // Replace Alef Maqsurah with Ya
    text = text.replaceAll('ى', 'ي');
    // Remove Diacritics
    text = text.replaceAll(RegExp(r'[\u064B-\u065F]'), '');

    // Digits
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const latinDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    for (int i = 0; i < arabicDigits.length; i++) {
      text = text.replaceAll(arabicDigits[i], latinDigits[i]);
    }

    // Flatten whitespace
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    return text;
  }

  /// Determines the pricing divisor.
  /// Standard: 0.82
  /// Selah El Telmeez: 0.825
  /// Others (like Al-Ta'sis): 0.80 based on map.
  double _getPricingDivisor(String? publisher, String? grade) {
    if (publisher == null) {
      return BookParsingConstants.defaultDivisor;
    }

    // Hard Fix for Al-Ta'sis Pricing logic
    // We check both specific string 'التاسيس' and variations just in case
    if (publisher == 'التاسيس' || publisher.contains('تاسيس')) {
      return 0.80; // Explicit per user request
    }
    if (publisher == 'التأسيس' || publisher.contains('تأسيس')) {
      return 0.80;
    }

    // Check specific map overrides
    // We try exact match first
    if (BookParsingConstants.publisherDivisors.containsKey(publisher)) {
      return BookParsingConstants.publisherDivisors[publisher]!;
    }

    // Logic for Selah
    if (publisher == 'سلاح التلميذ' || publisher.contains('سلاح')) {
      return BookParsingConstants.selahElTelmeezDivisor;
    }

    // Logic for Bit By Bit
    // 1-3 Primary (ب) -> 0.80
    // Others -> 0.82 (default)
    if (publisher == 'بيت باي بيت') {
      if (grade != null && grade.contains('ب')) {
        // Safe extraction of grade number
        final numStr = grade.replaceAll(RegExp(r'[^0-9]'), '');
        final num = int.tryParse(numStr);
        if (num != null && num <= 3) {
          return 0.80;
        }
      }
    }

    return BookParsingConstants.defaultDivisor;
  }
}
