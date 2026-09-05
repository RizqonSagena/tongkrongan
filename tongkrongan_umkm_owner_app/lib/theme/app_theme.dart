import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color palette based on HTML design tokens
  static const Color primary = Color(0xFFAD2C00);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFFD34011);
  static const Color onPrimaryContainer = Color(0xFFFFFBFF);
  static const Color primaryFixed = Color(0xFFFFDBD1);
  static const Color onPrimaryFixed = Color(0xFF3B0900);
  static const Color primaryFixedDim = Color(0xFFFFB5A0);
  static const Color onPrimaryFixedVariant = Color(0xFF872000);

  static const Color secondary = Color(0xFF1B6D24);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFA0F399);
  static const Color onSecondaryContainer = Color(0xFF217128);
  static const Color secondaryFixed = Color(0xFFA3F69C);
  static const Color onSecondaryFixed = Color(0xFF002204);
  static const Color secondaryFixedDim = Color(0xFF88D982);
  static const Color onSecondaryFixedVariant = Color(0xFF005312);

  static const Color tertiary = Color(0xFF924700);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFFB75B00);
  static const Color onTertiaryContainer = Color(0xFFFFFBFF);
  static const Color tertiaryFixed = Color(0xFFFFDCC6);
  static const Color onTertiaryFixed = Color(0xFF311300);
  static const Color tertiaryFixedDim = Color(0xFFFFB786);
  static const Color onTertiaryFixedVariant = Color(0xFF723600);

  static const Color surface = Color(0xFFFCF9F8);
  static const Color onSurface = Color(0xFF1B1C1C);
  static const Color surfaceDim = Color(0xFFDCD9D9);
  static const Color surfaceBright = Color(0xFFFCF9F8);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F3F2);
  static const Color surfaceContainer = Color(0xFFF0EDED);
  static const Color surfaceContainerHigh = Color(0xFFEAE7E7);
  static const Color surfaceContainerHighest = Color(0xFFE5E2E1);

  static const Color onSurfaceVariant = Color(0xFF5A413A);
  static const Color outline = Color(0xFF8F7068);
  static const Color outlineVariant = Color(0xFFE3BEB5);

  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color background = Color(0xFFFCF9F8);
  static const Color onBackground = Color(0xFF1B1C1C);

  static const Color inverseSurface = Color(0xFF303030);
  static const Color inverseOnSurface = Color(0xFFF3F0EF);
  static const Color inversePrimary = Color(0xFFFFB5A0);
  static const Color surfaceVariant = Color(0xFFE5E2E1);
  static const Color surfaceTint = Color(0xFFB12D00);

  // Spacing constants
  static const double spaceXxs = 4.0;
  static const double spaceXs = 8.0;
  static const double spaceSm = 12.0;
  static const double spaceMd = 16.0;
  static const double spaceLg = 20.0;
  static const double spaceXl = 24.0;
  static const double space2xl = 32.0;
  static const double space3xl = 48.0;

  static const double marginMobile = 16.0;
  static const double gutterMobile = 12.0;
  static const double touchTargetMin = 48.0;

  // Border radius
  static const double radiusDefault = 4.0;
  static const double radiusLg = 8.0;
  static const double radiusXl = 12.0;
  static const double radiusFull = 9999.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        primaryContainer: primaryContainer,
        onPrimaryContainer: onPrimaryContainer,
        secondary: secondary,
        onSecondary: onSecondary,
        secondaryContainer: secondaryContainer,
        onSecondaryContainer: onSecondaryContainer,
        tertiary: tertiary,
        onTertiary: onTertiary,
        tertiaryContainer: tertiaryContainer,
        onTertiaryContainer: onTertiaryContainer,
        error: error,
        onError: onError,
        errorContainer: errorContainer,
        onErrorContainer: onErrorContainer,
        surface: surface,
        onSurface: onSurface,
        onSurfaceVariant: onSurfaceVariant,
        outline: outline,
        outlineVariant: outlineVariant,
        background: background,
        onBackground: onBackground,
        inverseSurface: inverseSurface,
        onInverseSurface: inverseOnSurface,
        inversePrimary: inversePrimary,
        surfaceVariant: surfaceVariant,
        surfaceTint: surfaceTint,
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme().copyWith(
        // Headline styles
        headlineLarge: GoogleFonts.plusJakartaSans(
          fontSize: 24,
          height: 32 / 24,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          fontSize: 20,
          height: 28 / 20,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        headlineSmall: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          height: 24 / 18,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        
        // Body styles
        bodyLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          height: 24 / 16,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        bodyMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          height: 20 / 14,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        bodySmall: GoogleFonts.plusJakartaSans(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w400,
          color: onSurface,
        ),
        
        // Label styles
        labelLarge: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          height: 20 / 16,
          fontWeight: FontWeight.w700,
          color: onSurface,
        ),
        labelMedium: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          height: 18 / 14,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        labelSmall: GoogleFonts.plusJakartaSans(
          fontSize: 11,
          height: 14 / 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.04,
          color: onSurface,
        ),
        
        // Display currency
        displayLarge: GoogleFonts.plusJakartaSans(
          fontSize: 32,
          height: 40 / 32,
          letterSpacing: -0.02,
          fontWeight: FontWeight.w800,
          color: onSurface,
        ),
        displayMedium: GoogleFonts.plusJakartaSans(
          fontSize: 26,
          height: 34 / 26,
          letterSpacing: -0.02,
          fontWeight: FontWeight.w800,
          color: onSurface,
        ),
      ),
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: surface.withOpacity(0.85),
        foregroundColor: onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        titleTextStyle: GoogleFonts.plusJakartaSans(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
      ),
      
      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
          minimumSize: const Size(0, touchTargetMin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusFull),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      
      // Text Button Theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Outlined Button Theme
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: const BorderSide(color: outline),
          minimumSize: const Size(0, touchTargetMin),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusXl),
          ),
          textStyle: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          borderSide: const BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusXl),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spaceMd,
          vertical: spaceMd,
        ),
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: onSurface,
        ),
        hintStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: outline.withOpacity(0.6),
        ),
      ),
      
      // Card Theme
      cardTheme: CardTheme(
        color: surfaceContainerLowest,
        shadowColor: onSurface.withOpacity(0.05),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXl),
        ),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: surfaceContainerHigh,
        selectedColor: primary,
        labelStyle: GoogleFonts.plusJakartaSans(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusFull),
        ),
      ),
      
      // FloatingActionButton Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: onPrimary,
        shape: CircleBorder(),
      ),
    );
  }
}

// Custom text styles for specific use cases
class AppTextStyles {
  static TextStyle get displayCurrency => GoogleFonts.plusJakartaSans(
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: -0.02,
    fontWeight: FontWeight.w800,
    color: AppTheme.onSurface,
  );
  
  static TextStyle get displayCurrencyMobile => GoogleFonts.plusJakartaSans(
    fontSize: 26,
    height: 34 / 26,
    letterSpacing: -0.02,
    fontWeight: FontWeight.w800,
    color: AppTheme.onSurface,
  );
  
  static TextStyle get numeralStat => GoogleFonts.plusJakartaSans(
    fontSize: 20,
    height: 26 / 20,
    fontWeight: FontWeight.w700,
    color: AppTheme.onSurface,
  );
}