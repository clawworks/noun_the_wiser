import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              // Header with user info and sign out
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // User info
                  authState.when(
                    data:
                        (user) =>
                            user != null
                                ? Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      child: Text(
                                        user.name[0].toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: ThemeConstants.spacingSm,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Welcome, ${user.name}!',
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (user.isAnonymous)
                                          Text(
                                            'Anonymous User',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.bodySmall?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.6),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                )
                                : const SizedBox.shrink(),
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const SizedBox.shrink(),
                  ),

                  // Sign out button
                  IconButton(
                    onPressed: () => _showSignOutDialog(context, ref),
                    icon: const Icon(Icons.logout),
                    tooltip: 'Sign Out',
                  ),
                ],
              ),

              const SizedBox(height: ThemeConstants.spacingXl),

              // Main content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo/Icon
                    Icon(
                      Icons.psychology,
                      size: 120,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: ThemeConstants.spacingLg),

                    // Welcome Text
                    Text(
                      'Welcome to',
                      style: Theme.of(
                        context,
                      ).textTheme.headlineMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: ThemeConstants.spacingSm),
                    Text(
                      AppConstants.appName,
                      style: Theme.of(
                        context,
                      ).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: ThemeConstants.spacingMd),
                    Text(
                      'The ultimate team guessing game!',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: ThemeConstants.spacingXl),

                    // Game Options
                    _buildGameOption(
                      context,
                      icon: Icons.add_circle_outline,
                      title: 'Create New Game',
                      subtitle: 'Start a new game and invite friends',
                      onTap: () {
                        // TODO: Navigate to create game page
                        _showComingSoon(context);
                      },
                    ),
                    const SizedBox(height: ThemeConstants.spacingMd),
                    _buildGameOption(
                      context,
                      icon: Icons.join_full,
                      title: 'Join Game',
                      subtitle: 'Enter a join code to join existing game',
                      onTap: () {
                        // TODO: Navigate to join game page
                        _showComingSoon(context);
                      },
                    ),
                    const SizedBox(height: ThemeConstants.spacingLg),

                    // How to Play Button
                    TextButton.icon(
                      onPressed: () {
                        _showHowToPlay(context);
                      },
                      icon: const Icon(Icons.help_outline),
                      label: const Text('How to Play'),
                      style: TextButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGameOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: ThemeConstants.spacingMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: ThemeConstants.spacingXs),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sign Out'),
            content: const Text('Are you sure you want to sign out?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref.read(authNotifierProvider.notifier).signOut();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Sign Out'),
              ),
            ],
          ),
    );
  }

  void _showComingSoon(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Coming Soon!'),
            content: const Text(
              'This feature is under development. Stay tuned!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showHowToPlay(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('How to Play'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildHowToPlayStep(
                    '1. Teams',
                    'Players are divided into two teams. Each team has one clue giver.',
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  _buildHowToPlayStep(
                    '2. Categories',
                    'Teams compete to guess three nouns: Person, Place, and Thing.',
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  _buildHowToPlayStep(
                    '3. Questions',
                    'Team members ask questions to their clue giver to get hints.',
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  _buildHowToPlayStep(
                    '4. Guessing',
                    'Make guesses based on the clues. First team to guess all three wins!',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Got it!'),
              ),
            ],
          ),
    );
  }

  Widget _buildHowToPlayStep(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(description, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
