/// Math utilities for financial calculations
/// Enforces 2-decimal precision on all monetary values to prevent
/// floating point artifacts like 10.299999999
class MathUtils {
  /// Rounds a double to 2 decimal places for monetary precision
  /// Uses string parsing for maximum accuracy in financial calculations
  ///
  /// Example:
  /// ```dart
  /// MathUtils.round(10.299999999) // Returns 10.30
  /// MathUtils.round(5.555) // Returns 5.56 (banker's rounding)
  /// ```
  static double round(double value) {
    // Handle edge cases
    if (value.isNaN || value.isInfinite) return 0.0;

    // String-based parsing is safer for display and storage
    return double.parse(value.toStringAsFixed(2));
  }

  /// Alternative rounding using multiplication (faster but less safe for edge cases)
  /// Use this for intermediate calculations, use round() for final values
  static double roundFast(double value) {
    if (value.isNaN || value.isInfinite) return 0.0;
    return (value * 100).roundToDouble() / 100;
  }

  /// Rounds a value and ensures it's non-negative (for amounts like totals)
  static double roundPositive(double value) {
    final rounded = round(value);
    return rounded < 0 ? 0.0 : rounded;
  }

  /// Calculates percentage with proper rounding
  /// Example: percentageOf(100, 15) = 15.00
  static double percentageOf(double amount, double percentage) {
    return round(amount * (percentage / 100));
  }

  /// Calculates the difference between two amounts with proper rounding
  static double subtract(double a, double b) {
    return round(a - b);
  }

  /// Calculates the sum of two amounts with proper rounding
  static double add(double a, double b) {
    return round(a + b);
  }

  /// Calculates the product of two amounts with proper rounding
  static double multiply(double a, double b) {
    return round(a * b);
  }

  /// Safely divides two numbers with proper rounding
  /// Returns 0 if divisor is 0 to avoid division by zero
  static double divide(double dividend, double divisor) {
    if (divisor == 0) return 0.0;
    return round(dividend / divisor);
  }
}
