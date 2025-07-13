import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF9C27B0); // Vibrant Purple
  static const Color taskCardGradientStart = Color(
    0xFF9B51E0,
  ); // Gradient Purple Start
  static const Color taskCardGradientEnd = Color(
    0xFF6A11CB,
  ); // Gradient Purple End
  static const Color backgroundColor = Color(0xFFF8F8F8); // Light Greyish White
  static const Color cardColor = Color(0xFFFFFFFF); // Pure White
  static const Color textPrimary = Color(0xFF1A1A1A); // Black / Dark Grey
  static const Color textSecondary = Color(
    0xFFA3A1A1,
  ); // Light Grey (for subtext)
  static const Color errorColor = Color(0xFFD32F2F); // Standard error color
  static const Color tabSelectedIndicator = Colors.white; // White
  static const Color tabUnselectedText = Color(0xFFA3A1A1); // Grey
  static const Color progressTileIcon = Color(0xFF9B51E0); // Purple Circle
  static const Color bottomNavIconInactive = Color(0xFF757575); // Grey Inactive
  static const Color bottomNavIconActive = Color(0xFF9B51E0); // Selected Purple
  static const Color successColor = Color(0xFF4CAF50); // Success Green

  /// Returns the light theme
  static ThemeData get light => lightTheme();

  /// Returns the dark theme
  static ThemeData get dark => darkTheme();

  /// Returns theme based on brightness
  static ThemeData getTheme(Brightness brightness) {
    return brightness == Brightness.dark ? dark : light;
  }

  /// Returns theme based on context
  static ThemeData getThemeFromContext(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return getTheme(brightness);
  }
}

/// Returns the appropriate font family based on the platform
/// SF Pro on iOS, Inter on Android
TextTheme _getPlatformTextTheme({bool isDark = false}) {
  final textColor = isDark ? Colors.white : AppTheme.textPrimary;
  final secondaryTextColor = isDark ? Colors.white70 : AppTheme.textSecondary;

  final TextTheme baseTextTheme = Platform.isIOS
      ? const TextTheme()
      : GoogleFonts.interTextTheme();

  return baseTextTheme.copyWith(
    displayLarge: baseTextTheme.displayLarge?.copyWith(
      // color: colorScheme.onSurface,
      color: textColor,
      fontSize: 57.0,
    ),
    displayMedium: baseTextTheme.displayMedium?.copyWith(
      color: textColor,
      fontSize: 45.0,
    ),
    displaySmall: baseTextTheme.displaySmall?.copyWith(
      color: textColor,
      fontSize: 36.0,
    ),
    headlineLarge: baseTextTheme.headlineLarge?.copyWith(
      color: textColor,
      fontSize: 32.0,
    ),
    headlineMedium: baseTextTheme.headlineMedium?.copyWith(
      color: textColor,
      fontSize: 28.0,
    ),
    headlineSmall: baseTextTheme.headlineSmall?.copyWith(
      color: textColor,
      fontSize: 24.0,
    ),
    titleLarge: baseTextTheme.titleLarge?.copyWith(
      color: textColor,
      fontSize: 22.0,
    ),
    titleMedium: baseTextTheme.titleMedium?.copyWith(
      color: textColor,
      fontSize: 16.0,
    ),
    titleSmall: baseTextTheme.titleSmall?.copyWith(
      color: secondaryTextColor,
      fontSize: 14.0,
    ),
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(
      color: textColor,
      fontSize: 16.0,
    ),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(
      color: textColor,
      fontSize: 14.0,
    ),
    bodySmall: baseTextTheme.bodySmall?.copyWith(
      color: secondaryTextColor,
      fontSize: 12.0,
    ),
    labelLarge: baseTextTheme.labelLarge?.copyWith(
      color: secondaryTextColor,
      fontSize: 14.0,
    ),
    labelMedium: baseTextTheme.labelMedium?.copyWith(
      color: secondaryTextColor,
      fontSize: 12.0,
    ),
    labelSmall: baseTextTheme.labelSmall?.copyWith(
      color: secondaryTextColor,
      fontSize: 11.0,
    ),
  );
}

/// Defines the light theme for the application.
ThemeData lightTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: AppTheme.primaryColor,
    scaffoldBackgroundColor: AppTheme.backgroundColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    cardTheme: CardThemeData(
      color: AppTheme.cardColor,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    textTheme: _getPlatformTextTheme(isDark: false),
    colorScheme: const ColorScheme.light(
      primary: AppTheme.primaryColor,
      error: AppTheme.errorColor,
      surface: AppTheme.cardColor,
    ),
  );
}

/// Defines the dark theme for the application.
ThemeData darkTheme() {
  const darkBackground = Color(0xFF121212);
  const darkSurface = Color(0xFF1E1E1E);

  return ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: AppTheme.primaryColor,
    scaffoldBackgroundColor: darkBackground,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    cardTheme: CardThemeData(
      color: darkSurface,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
    textTheme: _getPlatformTextTheme(isDark: true),
    colorScheme: const ColorScheme.dark(
      primary: AppTheme.primaryColor,
      error: AppTheme.errorColor,
      surface: darkSurface,
    ),
  );
}
