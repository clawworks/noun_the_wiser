import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../auth/domain/user.dart';
import '../providers/game_providers.dart';
import '../../domain/game.dart';
import '../pages/team_assignment_page.dart';

class GameLobbyPage extends ConsumerStatefulWidget {
  final String gameId;

  const GameLobbyPage({super.key, required this.gameId});

  @override
  ConsumerState<GameLobbyPage> createState() => _GameLobbyPageState();
}

class _GameLobbyPageState extends ConsumerState<GameLobbyPage> {
  @override
  void initState() {
    super.initState();
    // Start watching the game for real-time updates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameNotifierProvider.notifier).watchGame(widget.gameId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameNotifierProvider);
    final currentUser = ref.watch(authNotifierProvider).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Lobby'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () => _showLeaveGameDialog(context),
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Leave Game',
          ),
        ],
      ),
      body: SafeArea(
        child: gameState.when(
          data:
              (game) =>
                  game != null
                      ? _buildLobbyContent(game, currentUser)
                      : _buildErrorState(),
          loading: () => _buildLoadingState(),
          error: (error, stack) => _buildErrorState(),
        ),
      ),
    );
  }

  Widget _buildLobbyContent(Game game, User? currentUser) {
    final isHost = currentUser?.id == game.players.first.id;
    final canStartGame = game.players.length >= 2 && isHost;

    return Padding(
      padding: const EdgeInsets.all(ThemeConstants.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Game Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstants.spacingLg),
              child: Column(
                children: [
                  Text(
                    'Game Lobby',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ThemeConstants.spacingLg,
                      vertical: ThemeConstants.spacingMd,
                    ),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(context).colorScheme.surfaceContainerHighest,
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
                        Flexible(
                          child: Text(
                            'Join Code: ',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            game.joinCode,
                            style: Theme.of(
                              context,
                            ).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: ThemeConstants.spacingMd),
                        IconButton(
                          onPressed: () => _copyJoinCode(game.joinCode),
                          icon: const Icon(Icons.copy),
                          tooltip: 'Copy join code',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Text(
                    '${game.players.length} player${game.players.length == 1 ? '' : 's'} joined',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingLg),

          // Players List
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(ThemeConstants.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Players',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: ThemeConstants.spacingMd),
                    Expanded(
                      child:
                          game.players.isEmpty
                              ? _buildEmptyPlayersState()
                              : _buildPlayersList(game.players, currentUser),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingLg),

          // Start Game Button (only for host)
          if (isHost) ...[
            SizedBox(
              height: 56,
              child: ElevatedButton(
                onPressed: canStartGame ? () => _startGame(game) : null,
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
                child: Text(
                  canStartGame ? 'Start Game' : 'Need at least 2 players',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ] else ...[
            // Waiting for host message
            Container(
              padding: const EdgeInsets.all(ThemeConstants.spacingLg),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
              ),
              child: Row(
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(width: ThemeConstants.spacingMd),
                  Text(
                    'Waiting for host to start the game...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayersList(List<User> players, User? currentUser) {
    return ListView.builder(
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        final isCurrentUser = currentUser?.id == player.id;
        final isHost = index == 0;

        return Card(
          margin: const EdgeInsets.only(bottom: ThemeConstants.spacingSm),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor:
                  isHost
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
              child: Text(
                player.name[0].toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Row(
              children: [
                Text(
                  player.name,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                if (isCurrentUser) ...[
                  const SizedBox(width: ThemeConstants.spacingSm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: ThemeConstants.spacingXs,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'You',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            subtitle: Text(
              isHost ? 'Host' : 'Player',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            trailing:
                isHost
                    ? Icon(
                      Icons.star,
                      color: Theme.of(context).colorScheme.primary,
                    )
                    : null,
          ),
        );
      },
    );
  }

  Widget _buildEmptyPlayersState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: Theme.of(
              context,
            ).colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: ThemeConstants.spacingMd),
          Text(
            'No players yet',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingSm),
          Text(
            'Share the join code with friends',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: ThemeConstants.spacingLg),
          Text('Loading game...'),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: ThemeConstants.spacingLg),
          Text(
            'Failed to load game',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(height: ThemeConstants.spacingMd),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }

  Future<void> _copyJoinCode(String joinCode) async {
    try {
      await Clipboard.setData(ClipboardData(text: joinCode));
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

  void _showLeaveGameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Leave Game'),
            content: const Text('Are you sure you want to leave this game?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _leaveGame();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
                child: const Text('Leave'),
              ),
            ],
          ),
    );
  }

  Future<void> _leaveGame() async {
    final currentUser = ref.read(authNotifierProvider).value;
    if (currentUser != null) {
      try {
        await ref
            .read(gameNotifierProvider.notifier)
            .leaveGame(widget.gameId, currentUser.id);
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to leave game: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }
  }

  Future<void> _startGame(Game game) async {
    try {
      print('Starting game: ${widget.gameId}');
      await ref.read(gameNotifierProvider.notifier).startGame(widget.gameId);
      print('Game started successfully');

      if (mounted) {
        // Navigate to team assignment page
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => TeamAssignmentPage(gameId: widget.gameId),
          ),
        );
      }
    } catch (e, stackTrace) {
      print('Error starting game: $e');
      print('Stack trace: $stackTrace');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start game: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}
