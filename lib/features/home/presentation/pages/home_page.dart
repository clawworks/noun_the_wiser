import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Icon
            Icon(
              Icons.psychology,
              size: 120,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 32),

            // Welcome Text
            Text(
              'Welcome to',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              AppConstants.appName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'The ultimate team guessing game!',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 64),

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
            const SizedBox(height: 16),
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
            const SizedBox(height: 24),

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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
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
                  const SizedBox(height: 16),
                  _buildHowToPlayStep(
                    '2. Categories',
                    'Teams compete to guess three nouns: Person, Place, and Thing.',
                  ),
                  const SizedBox(height: 16),
                  _buildHowToPlayStep(
                    '3. Questions',
                    'Team members ask questions to their clue giver to get hints.',
                  ),
                  const SizedBox(height: 16),
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
