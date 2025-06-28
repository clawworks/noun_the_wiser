import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/utils/join_code_generator.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class JoinGamePage extends ConsumerStatefulWidget {
  const JoinGamePage({super.key});

  @override
  ConsumerState<JoinGamePage> createState() => _JoinGamePageState();
}

class _JoinGamePageState extends ConsumerState<JoinGamePage> {
  final _formKey = GlobalKey<FormState>();
  final _joinCodeController = TextEditingController();
  bool _isJoining = false;

  @override
  void dispose() {
    _joinCodeController.dispose();
    super.dispose();
  }

  Future<void> _joinGame() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isJoining = true);

    try {
      final user = ref.read(authNotifierProvider).value;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      final joinCode = _joinCodeController.text.trim().toUpperCase();

      // TODO: Join game in Firebase
      // await ref.read(gameRepositoryProvider).joinGame(joinCode, user);

      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1000));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully joined game with code: $joinCode'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );

        // TODO: Navigate to game lobby
        _showComingSoon(context);
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to join game: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isJoining = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Join Game'), elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Icon(
                  Icons.join_full,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: ThemeConstants.spacingLg),
                Text(
                  'Join Game',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ThemeConstants.spacingMd),
                Text(
                  'Enter the join code provided by the game host',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ThemeConstants.spacingXl),

                // Join Code Input
                TextFormField(
                  controller: _joinCodeController,
                  decoration: InputDecoration(
                    labelText: 'Join Code',
                    hintText: 'Enter 6-character code',
                    prefixIcon: const Icon(Icons.code),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ThemeConstants.radiusMd,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ThemeConstants.radiusMd,
                      ),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        ThemeConstants.radiusMd,
                      ),
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2,
                      ),
                    ),
                  ),
                  textCapitalization: TextCapitalization.characters,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _joinGame(),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a join code';
                    }
                    final code = value.trim().toUpperCase();
                    if (!JoinCodeGenerator.isValid(code)) {
                      return 'Please enter a valid 6-character join code';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: ThemeConstants.spacingLg),

                // Join Game Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isJoining ? null : _joinGame,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ThemeConstants.radiusMd,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child:
                        _isJoining
                            ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                            : const Text(
                              'Join Game',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingXl),

                // Info Card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(ThemeConstants.spacingLg),
                    child: Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: ThemeConstants.spacingMd),
                        Text(
                          'How to Join',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: ThemeConstants.spacingMd),
                        Text(
                          'Ask the game host for the 6-character join code. It will look something like "ABC123".',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
              'Game lobby and real-time gameplay features are under development.',
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
}
