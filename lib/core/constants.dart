import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppConstants {
  static const Color primaryBackground = Colors.black;
  static const Color accentGold = Color(0xFFD4AF37); 
  static const Color textColor = Colors.grey;
  static const Color successColor = Colors.green; // Industry-standard green for success
  static const Color errorColor = Colors.red; // Industry-standard red for errors

  static TextStyle get headlineFont => GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: accentGold,
      );

  static TextStyle get bodyFont => GoogleFonts.roboto(
        fontWeight: FontWeight.normal,
        color: textColor,
      );

  static TextStyle get buttonFont => GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        color: primaryBackground,
      );

  static TextStyle get linkFont => GoogleFonts.roboto(
        fontWeight: FontWeight.w500,
        color: accentGold,
      );
  
  static TextStyle get snackBarText => GoogleFonts.roboto(
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: 14,
      );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: primaryBackground,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headlineSmall: headlineFont.copyWith(fontSize: 36),
      bodyLarge: bodyFont.copyWith(fontSize: 16),
      bodyMedium: bodyFont.copyWith(fontSize: 14),
      labelLarge: buttonFont.copyWith(fontSize: 18),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentGold),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentGold),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: accentGold, width: 2),
      ),
      labelStyle: bodyFont,
      hintStyle: bodyFont.copyWith(color: textColor.withOpacity(0.7)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentGold,
        foregroundColor: primaryBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: buttonFont.copyWith(fontSize: 18),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 6,
    ),
  );

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static SnackBar successSnackBar(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: snackBarText,
            ),
          ),
        ],
      ),
      backgroundColor: successColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
      elevation: 6,
      margin: const EdgeInsets.all(16),
    );
  }

  static SnackBar errorSnackBar(String message) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: snackBarText,
            ),
          ),
        ],
      ),
      backgroundColor: errorColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'Dismiss',
        textColor: Colors.white,
        onPressed: () {},
      ),
      elevation: 6,
      margin: const EdgeInsets.all(16),
    );
  }
}