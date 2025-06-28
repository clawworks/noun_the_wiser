import 'package:flutter/material.dart';

class ThemeConstants {
  // Brand Colors (from specs)
  static const Color brandGreen = Color(0xFF57CC02);
  static const Color brandBlue = Color(0xFF1CB0F6);
  static const Color brandPurple = Color(0xFF6A5FE8);
  static const Color brandYellow = Color(0xFFFFC702);

  // Light theme colors - Clean, open feel
  static const Color lightPrimary = brandPurple;
  static const Color lightPrimaryVariant = Color(0xFF5A4FD8);
  static const Color lightSecondary = brandBlue;
  static const Color lightSecondaryVariant = Color(0xFF1A9FE6);
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFE53E3E);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnBackground = Color(0xFF1A1A1A);
  static const Color lightOnSurface = Color(0xFF1A1A1A);
  static const Color lightOnError = Color(0xFFFFFFFF);

  // Dark theme colors
  static const Color darkPrimary = brandPurple;
  static const Color darkPrimaryVariant = Color(0xFF7A6FF8);
  static const Color darkSecondary = brandBlue;
  static const Color darkSecondaryVariant = Color(0xFF3CC0FF);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkError = Color(0xFFF56565);
  static const Color darkOnPrimary = Color(0xFFFFFFFF);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnError = Color(0xFF000000);

  // Team colors using brand colors
  static const Color team1Color = brandBlue;
  static const Color team2Color = brandGreen;

  // Game status colors
  static const Color successColor = brandGreen;
  static const Color warningColor = brandYellow;
  static const Color infoColor = brandBlue;

  // Text styles - Clean, modern typography
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
    height: 1.3,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.4,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 1.5,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.3,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 1.2,
  );

  // Spacing constants for clean layout
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // Border radius for clean, modern feel
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusFull = 999.0;

  // Shadows for depth without being boxy
  static const List<BoxShadow> shadowSm = [
    BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> shadowMd = [
    BoxShadow(color: Color(0x0F000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> shadowLg = [
    BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, 4)),
  ];
}
