import 'package:flutter/material.dart';

/// Centralised theme configuration for the COVID-19 Tracker.
///
/// Keeping all visual tokens in one place makes it easy to tweak the look
/// and feel without hunting through individual widgets. We lean on Material 3
/// and the Poppins font family for a clean, modern aesthetic.
class AppTheme {
  AppTheme._(); // prevent instantiation

  // Brand colours used across the dashboard
  static const primaryBlue = Color(0xFF1565C0);
  static const darkBlue = Color(0xFF0D47A1);

  /// Light theme used throughout the app.
  ///
  /// Key design decisions:
  /// - Blue gradient-ready palette for a calm, clinical feel.
  /// - Cards have subtle elevation and generous corner radii for a premium look.
  /// - The scaffold background is a soft grey-blue to give cards visual separation.
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF0F4F8),
        cardTheme: CardTheme(
          elevation: 1,
          shadowColor: Colors.black.withOpacity(0.06),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.white,
          ),
        ),
      );
}
