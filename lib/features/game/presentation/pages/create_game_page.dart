import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/utils/join_code_generator.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../providers/game_providers.dart';
import '../../domain/game.dart';
import 'game_page.dart';

class CreateGamePage extends ConsumerStatefulWidget {
  const CreateGamePage({super.key});

  @override
  ConsumerState<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends ConsumerState<CreateGamePage> {
  final _formKey = GlobalKey<FormState>();
  final _gameNameController = TextEditingController();
  bool _isCreating = false;
  String? _generatedJoinCode;

  @override
  void dispose() {
    _gameNameController.dispose();
    super.dispose();
  }

  Future<void> _createGame() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCreating = true);

    try {
      final user = ref.read(authNotifierProvider).value;
      if (user == null) {
        throw Exception('User not authenticated');
      }

      // Generate a unique join code
      final joinCode = JoinCodeGenerator.generate();

      // Create the game
      final game = Game.create(joinCode: joinCode, creator: user);

      // Save game to Firebase
      await ref.read(gameNotifierProvider.notifier).createGame(game);

      setState(() {
        _generatedJoinCode = joinCode;
        _isCreating = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Game "${_gameNameController.text.trim()}" created successfully!',
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
    } catch (error) {
      setState(() => _isCreating = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create game: $error'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _copyJoinCode() async {
    if (_generatedJoinCode != null) {
      try {
        await Clipboard.setData(ClipboardData(text: _generatedJoinCode!));
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Join code copied to clipboard!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to copy join code: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  void _navigateToLobby() {
    final game = ref.read(gameNotifierProvider).value;
    if (game != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => GamePage(gameId: game.id)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Game'), elevation: 0),
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
                  Icons.add_circle_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: ThemeConstants.spacingLg),
                Text(
                  'Create New Game',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ThemeConstants.spacingMd),
                Text(
                  'Start a new game and invite friends to join',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ThemeConstants.spacingXl),

                // Game Name Input
                TextFormField(
                  controller: _gameNameController,
                  decoration: InputDecoration(
                    labelText: 'Game Name',
                    hintText: 'Enter a name for your game',
                    prefixIcon: const Icon(Icons.games),
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
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a game name';
                    }
                    if (value.trim().length < 3) {
                      return 'Game name must be at least 3 characters';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _createGame(),
                ),
                const SizedBox(height: ThemeConstants.spacingLg),

                // Create Game Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isCreating ? null : _createGame,
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
                        _isCreating
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
                              'Create Game',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                ),

                // Join Code Display
                if (_generatedJoinCode != null) ...[
                  const SizedBox(height: ThemeConstants.spacingXl),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(ThemeConstants.spacingLg),
                      child: Column(
                        children: [
                          Text(
                            'Join Code',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: ThemeConstants.spacingMd),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: ThemeConstants.spacingLg,
                              vertical: ThemeConstants.spacingMd,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(
                                ThemeConstants.radiusMd,
                              ),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.outline,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _generatedJoinCode!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(width: ThemeConstants.spacingMd),
                                IconButton(
                                  onPressed: _copyJoinCode,
                                  icon: const Icon(Icons.copy),
                                  tooltip: 'Copy join code',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: ThemeConstants.spacingMd),
                          Text(
                            'Share this code with friends to invite them to your game',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  ElevatedButton.icon(
                    onPressed: _navigateToLobby,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Go to Lobby'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      foregroundColor:
                          Theme.of(context).colorScheme.onSecondary,
                      padding: const EdgeInsets.symmetric(
                        horizontal: ThemeConstants.spacingLg,
                        vertical: ThemeConstants.spacingMd,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
