import 'package:flutter/material.dart';

/// Centralized color palette for the application.
/// Provides semantic naming for all colors used in the UI.
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============ Primary Colors ============
  /// Electric Blue - Primary action color
  static const Color primary = Color(0xFF3B82F6);

  /// Lighter Blue - for highlights and accents
  static const Color primaryLight = Color(0xFF60A5FA);

  /// Darker Blue - for pressed states
  static const Color primaryDark = Color(0xFF2563EB);

  // ============ Background Colors ============
  /// Deep Navy - Main background
  static const Color background = Color(0xFF0F172A);

  /// Darker variant for contrast areas (e.g., camera standby)
  static const Color backgroundDark = Color(0xFF111625);

  /// Card & Surface background
  static const Color card = Color(0xFF1E2439);

  /// Glassy dark slate for elevated surfaces
  static const Color surface = Color(0xFF1E293B);

  // ============ Semantic Colors ============
  /// Emerald Green - Success states
  static const Color success = Color(0xFF10B981);

  /// Light Green - for positive values
  static const Color successLight = Color(0xFF34D399);

  /// Rose Red - Error & destructive actions
  static const Color error = Color(0xFFEF4444);

  /// Rose Red variant
  static const Color errorAlt = Color(0xFFF43F5E);

  /// Amber Orange - Warnings & attention
  static const Color warning = Color(0xFFF59E0B);

  /// Secondary Orange - Accent highlights
  static const Color secondary = Color(0xFFF97316);

  // ============ Text Colors ============
  /// White - Primary text on dark backgrounds
  static const Color textPrimary = Colors.white;

  /// Soft grey - Secondary text
  static const Color textSecondary = Color(0xFF94A3B8);

  /// Muted text
  static const Color textMuted = Color(0xFF64748B);

  /// Hint text color
  static const Color textHint = Color(0xFF475569);

  // ============ Border & Divider Colors ============
  /// Subtle border color
  static const Color border = Color(0xFF334155);

  /// Very subtle border (10% white)
  static const Color borderSubtle = Color(0x1AFFFFFF);

  /// Divider color
  static const Color divider = Color(0xFF1E293B);

  // ============ Overlay Colors ============
  /// Black overlay for modals
  static const Color overlayDark = Color(0x80000000);

  /// Light overlay for glassmorphism effects
  static const Color overlayLight = Color(0x1AFFFFFF);

  // ============ Gradient Definitions ============
  /// Primary gradient (Blue)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Success gradient (Green)
  static const LinearGradient successGradient = LinearGradient(
    colors: [successLight, success],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Error gradient (Red)
  static const LinearGradient errorGradient = LinearGradient(
    colors: [error, errorAlt],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ Utility Methods ============
  /// Returns color with specified opacity
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }

  /// Get status color based on value comparison
  static Color getStockColor(int current, int min) {
    if (current < min) return error;
    if (current < min * 1.5) return warning;
    return success;
  }
}
