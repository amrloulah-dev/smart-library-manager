import 'package:flutter/material.dart';

class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  static const Color quietDark = Color(0xFF0F172A); // Deep Navy Background
  static const Color primaryBlue = Color(0xFF3B82F6); // Electric Blue
  static const Color secondaryOrange = Color(0xFFF97316); // Accent
  static const Color emeraldGreen = Color(0xFF10B981); // Success
  static const Color roseRed = Color(0xFFF43F5E); // Error
  static const Color glassyDark = Color(0xFF1E293B); // Dark Slate Cards
  static const Color white = Colors.white;
  static const Color softGrey = Color(0xFF94A3B8);

  // Font Family
  static const String fontFamily = 'Cairo';

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: fontFamily,
    scaffoldBackgroundColor: quietDark,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.dark(
      primary: primaryBlue,
      secondary: secondaryOrange,
      surface: glassyDark,
      error: roseRed,
      onPrimary: white,
      onSecondary: white,
      onSurface: white,
      onError: white,
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: quietDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: fontFamily,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: white,
      ),
      iconTheme: IconThemeData(color: white),
    ),

    // Card Theme
    cardTheme: CardThemeData(
      color: glassyDark,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    ),

    // Floating Action Button Theme
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: primaryBlue,
      foregroundColor: white,
    ),

    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: glassyDark,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryBlue, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: roseRed, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      hintStyle: TextStyle(color: white.withOpacity(0.5)),
    ),

    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    // Page Transitions
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),

    // Bottom Navigation Bar Theme
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      enableFeedback: true,
      backgroundColor: quietDark,
      selectedItemColor: primaryBlue,
      unselectedItemColor: softGrey,
      type: BottomNavigationBarType.fixed,
    ),
  );
}
