import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primary = Color(0xFF0E9F8E);
  static const background = Color(0xFFF7F9FB);
  static const surface = Colors.white;
  static const textDark = Color(0xFF1B2733);
  static const textMuted = Color(0xFF6B7A89);
  static const border = Color(0xFFE5EAF0);

  static const safe = Color(0xFF2FB36D);
  static const caution = Color(0xFFF5A524);
  static const danger = Color(0xFFE5484D);

  static ThemeData light() {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        surface: surface,
      ),
      scaffoldBackgroundColor: background,
    );
    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme)
          .apply(bodyColor: textDark, displayColor: textDark),
      appBarTheme: const AppBarTheme(
        backgroundColor: surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: textDark,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}