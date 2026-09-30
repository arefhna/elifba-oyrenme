import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Rənglər
  static const Color primaryGreen = Color(0xFF00695C);
  static const Color deepGreen = Color(0xFF004D40);
  static const Color lightGreen = Color(0xFF26A69A);
  static const Color accentGold = Color(0xFFD4AF37);
  static const Color softGold = Color(0xFFE8C766);
  static const Color creamBg = Color(0xFFF8F6F0);
  static const Color darkBg = Color(0xFF0F1414);
  static const Color darkCard = Color(0xFF1A2323);
  static const Color darkSurface = Color(0xFF212E2E);

  // Gradient-lər
  static LinearGradient get greenGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [deepGreen, primaryGreen, lightGreen],
      );

  static LinearGradient get goldGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [accentGold, softGold],
      );

  static LinearGradient get darkGradient => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0F1414), Color(0xFF1A2323)],
      );

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
        primary: primaryGreen,
        secondary: accentGold,
        surface: creamBg,
      ),
      scaffoldBackgroundColor: creamBg,
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: greenGradient),
        ),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: lightGreen,
        brightness: Brightness.dark,
        primary: lightGreen,
        secondary: softGold,
        surface: darkCard,
      ),
      scaffoldBackgroundColor: darkBg,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: darkGradient),
        ),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
