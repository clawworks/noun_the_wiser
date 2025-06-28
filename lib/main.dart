import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/theme_constants.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/auth/presentation/pages/anonymous_sign_in_page.dart';
import 'features/auth/presentation/providers/auth_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // Firebase not configured, continue without it for development
    debugPrint('Firebase not initialized: $e');
  }

  runApp(const ProviderScope(child: NounTheWiserApp()));
}

class NounTheWiserApp extends ConsumerWidget {
  const NounTheWiserApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system, // Default to system preference
      home: authState.when(
        data:
            (user) =>
                user != null ? const HomePage() : const AnonymousSignInPage(),
        loading: () => const _LoadingScreen(),
        error: (error, stack) => const AnonymousSignInPage(),
      ),
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
        surface: ThemeConstants.lightSurface,
        onSurface: ThemeConstants.lightOnSurface,
        error: ThemeConstants.lightError,
        onError: ThemeConstants.lightOnError,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: ThemeConstants.headline1.copyWith(
          color: ThemeConstants.lightOnSurface,
        ),
        headlineMedium: ThemeConstants.headline2.copyWith(
          color: ThemeConstants.lightOnSurface,
        ),
        headlineSmall: ThemeConstants.headline3.copyWith(
          color: ThemeConstants.lightOnSurface,
        ),
        bodyLarge: ThemeConstants.body1.copyWith(
          color: ThemeConstants.lightOnSurface,
        ),
        bodyMedium: ThemeConstants.body2.copyWith(
          color: ThemeConstants.lightOnSurface,
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
        surface: ThemeConstants.darkSurface,
        onSurface: ThemeConstants.darkOnSurface,
        error: ThemeConstants.darkError,
        onError: ThemeConstants.darkOnError,
      ),
      textTheme: GoogleFonts.interTextTheme().copyWith(
        headlineLarge: ThemeConstants.headline1.copyWith(
          color: ThemeConstants.darkOnSurface,
        ),
        headlineMedium: ThemeConstants.headline2.copyWith(
          color: ThemeConstants.darkOnSurface,
        ),
        headlineSmall: ThemeConstants.headline3.copyWith(
          color: ThemeConstants.darkOnSurface,
        ),
        bodyLarge: ThemeConstants.body1.copyWith(
          color: ThemeConstants.darkOnSurface,
        ),
        bodyMedium: ThemeConstants.body2.copyWith(
          color: ThemeConstants.darkOnSurface,
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

class _LoadingScreen extends StatelessWidget {
  const _LoadingScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.psychology,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
