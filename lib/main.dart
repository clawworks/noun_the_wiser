import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/theme_constants.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: NounTheWiserApp()));
}

class NounTheWiserApp extends ConsumerWidget {
  const NounTheWiserApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system, // Default to system preference
      home: const HomePage(),
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeConstants.lightPrimary,
        brightness: Brightness.light,
        primary: ThemeConstants.lightPrimary,
        onPrimary: ThemeConstants.lightOnPrimary,
        secondary: ThemeConstants.lightSecondary,
        onSecondary: ThemeConstants.lightOnSecondary,
        background: ThemeConstants.lightBackground,
        onBackground: ThemeConstants.lightOnBackground,
        surface: ThemeConstants.lightSurface,
        onSurface: ThemeConstants.lightOnSurface,
        error: ThemeConstants.lightError,
        onError: ThemeConstants.lightOnError,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: ThemeConstants.headline1.copyWith(
          color: ThemeConstants.lightOnBackground,
        ),
        headlineMedium: ThemeConstants.headline2.copyWith(
          color: ThemeConstants.lightOnBackground,
        ),
        headlineSmall: ThemeConstants.headline3.copyWith(
          color: ThemeConstants.lightOnBackground,
        ),
        bodyLarge: ThemeConstants.body1.copyWith(
          color: ThemeConstants.lightOnBackground,
        ),
        bodyMedium: ThemeConstants.body2.copyWith(
          color: ThemeConstants.lightOnBackground,
        ),
        labelLarge: ThemeConstants.button.copyWith(
          color: ThemeConstants.lightOnPrimary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeConstants.lightPrimary,
        foregroundColor: ThemeConstants.lightOnPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: ThemeConstants.headline3.copyWith(
          color: ThemeConstants.lightOnPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConstants.lightPrimary,
          foregroundColor: ThemeConstants.lightOnPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardTheme(
        color: ThemeConstants.lightSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ThemeConstants.darkPrimary,
        brightness: Brightness.dark,
        primary: ThemeConstants.darkPrimary,
        onPrimary: ThemeConstants.darkOnPrimary,
        secondary: ThemeConstants.darkSecondary,
        onSecondary: ThemeConstants.darkOnSecondary,
        background: ThemeConstants.darkBackground,
        onBackground: ThemeConstants.darkOnBackground,
        surface: ThemeConstants.darkSurface,
        onSurface: ThemeConstants.darkOnSurface,
        error: ThemeConstants.darkError,
        onError: ThemeConstants.darkOnError,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: ThemeConstants.headline1.copyWith(
          color: ThemeConstants.darkOnBackground,
        ),
        headlineMedium: ThemeConstants.headline2.copyWith(
          color: ThemeConstants.darkOnBackground,
        ),
        headlineSmall: ThemeConstants.headline3.copyWith(
          color: ThemeConstants.darkOnBackground,
        ),
        bodyLarge: ThemeConstants.body1.copyWith(
          color: ThemeConstants.darkOnBackground,
        ),
        bodyMedium: ThemeConstants.body2.copyWith(
          color: ThemeConstants.darkOnBackground,
        ),
        labelLarge: ThemeConstants.button.copyWith(
          color: ThemeConstants.darkOnPrimary,
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeConstants.darkPrimary,
        foregroundColor: ThemeConstants.darkOnPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: ThemeConstants.headline3.copyWith(
          color: ThemeConstants.darkOnPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConstants.darkPrimary,
          foregroundColor: ThemeConstants.darkOnPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
      cardTheme: CardTheme(
        color: ThemeConstants.darkSurface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
