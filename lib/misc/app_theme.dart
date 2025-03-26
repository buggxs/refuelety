import 'package:flutter/material.dart';

class AppTheme {
  // Farben für Light Theme
  final Color _primaryLight =
      const Color(0xFF1565C0); // Sanftes, professionelles Blau
  final Color _primaryContainerLight =
      const Color(0xFFE3F2FD); // Sehr helles Blau
  final Color _secondaryLight =
      const Color(0xFFFFD966); // Gedämpftes, sanftes Gelb
  final Color _errorLight =
      const Color(0xFFD32F2F); // Standard-Rot (unverändert)

// Farben für Dark Theme
  final Color _primaryDark = const Color(0xFF64B5F6); // Gedämpftes, helles Blau
  final Color _primaryContainerDark =
      const Color(0xFF0B224A); // Dunkles Blau (unverändert)
  final Color _secondaryDark = const Color(0xFFFFE082); // Sanftes, helles Gelb
  final Color _errorDark = const Color(0xFFEF5350); // Helles Rot (unverändert)

// Neutralfarben (unverändert)
  final Color _backgroundLight = const Color(0xFFF8F9FA);
  final Color _backgroundDark = const Color(0xFF121212);
  final Color _surfaceLight = const Color(0xFFFFFFFF);
  final Color _surfaceDark = const Color(0xFF1E1E1E);

  // Light Theme
  ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: _primaryLight,
        primaryContainer: _primaryContainerLight,
        secondary: _secondaryLight,
        error: _errorLight,
        surface: _backgroundLight,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: _primaryLight,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: _surfaceLight,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryLight,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryLight,
        foregroundColor: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Colors.black87,
        ),
        bodyMedium: TextStyle(
          color: Colors.black87,
        ),
      ),
    );
  }

  // Dark Theme
  ThemeData dark() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: _primaryDark,
        primaryContainer: _primaryContainerDark,
        secondary: _secondaryDark,
        error: _errorDark,
        surface: _backgroundDark,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: _primaryDark,
        foregroundColor: Colors.white,
      ),
      cardTheme: CardTheme(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: _surfaceDark,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryDark,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _primaryDark,
        foregroundColor: Colors.black,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: Colors.white,
        ),
        bodyMedium: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
