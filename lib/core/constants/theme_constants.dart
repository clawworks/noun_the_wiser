import 'package:flutter/material.dart';

class ThemeConstants {
  // Light theme colors
  static const Color lightPrimary = Color(0xFF6200EE);
  static const Color lightPrimaryVariant = Color(0xFF3700B3);
  static const Color lightSecondary = Color(0xFF03DAC6);
  static const Color lightSecondaryVariant = Color(0xFF018786);
  static const Color lightBackground = Color(0xFFFFFFFF);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightError = Color(0xFFB00020);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFF000000);
  static const Color lightOnBackground = Color(0xFF000000);
  static const Color lightOnSurface = Color(0xFF000000);
  static const Color lightOnError = Color(0xFFFFFFFF);

  // Dark theme colors
  static const Color darkPrimary = Color(0xFFBB86FC);
  static const Color darkPrimaryVariant = Color(0xFF3700B3);
  static const Color darkSecondary = Color(0xFF03DAC6);
  static const Color darkSecondaryVariant = Color(0xFF018786);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkError = Color(0xFFCF6679);
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnBackground = Color(0xFFFFFFFF);
  static const Color darkOnSurface = Color(0xFFFFFFFF);
  static const Color darkOnError = Color(0xFF000000);

  // Team colors
  static const Color team1Color = Color(0xFF2196F3);
  static const Color team2Color = Color(0xFFFF5722);

  // Game status colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color warningColor = Color(0xFFFF9800);
  static const Color infoColor = Color(0xFF2196F3);

  // Text styles
  static const TextStyle headline1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
