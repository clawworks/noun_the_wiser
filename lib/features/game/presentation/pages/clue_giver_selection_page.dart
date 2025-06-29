import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../domain/game.dart';
import '../providers/game_providers.dart';
import '../../../auth/domain/user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class ClueGiverSelectionPage extends ConsumerStatefulWidget {
  final String gameId;

  const ClueGiverSelectionPage({super.key, required this.gameId});

  @override
  ConsumerState<ClueGiverSelectionPage> createState() =>
      _ClueGiverSelectionPageState();
}

class _ClueGiverSelectionPageState
    extends ConsumerState<ClueGiverSelectionPage> {
  bool _isAssigning = false;

  @override
  void initState() {
    super.initState();
    // Watch the game for real-time updates
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameNotifierProvider.notifier).watchGame(widget.gameId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameAsync = ref.watch(gameNotifierProvider);
    final currentUserAsync = ref.watch(authNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: gameAsync.when(
          data: (game) {
            if (game == null) {
              return const Center(child: Text('Game not found'));
            }

            return currentUserAsync.when(
              data: (currentUser) => buildClueGiverContent(game, currentUser),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget buildClueGiverContent(Game game, User? currentUser) {
    final teams = game.teams;
    final isHost =
        game.players.isNotEmpty && game.players.first.id == currentUser?.id;

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              Text(
                'Clue Givers Selected!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                'Each team has a clue giver assigned. You can change the clue giver if needed.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Teams with Clue Givers
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(ThemeConstants.spacingLg),
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              final teamPlayers =
                  game.players
                      .where((player) => team.playerIds.contains(player.id))
                      .toList();
              final clueGiver =
                  team.clueGiverId != null
                      ? teamPlayers.firstWhere(
                        (player) => player.id == team.clueGiverId,
                        orElse: () => teamPlayers.first,
                      )
                      : null;

              return _buildTeamClueGiverCard(
                team,
                teamPlayers,
                clueGiver,
                game,
                currentUser,
              );
            },
          ),
        ),

        // Continue Button (only for host)
        if (isHost) ...[
          Container(
            padding: const EdgeInsets.all(ThemeConstants.spacingLg),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isAssigning ? null : _continueToGame,
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
                    _isAssigning
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
                          'Continue to Game',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTeamClueGiverCard(
    Team team,
    List<User> teamPlayers,
    User? clueGiver,
    Game game,
    User? currentUser,
  ) {
    final isCurrentUserInTeam = team.playerIds.contains(currentUser?.id);
    final isCurrentUserClueGiver = clueGiver?.id == currentUser?.id;

    return Card(
      margin: const EdgeInsets.only(bottom: ThemeConstants.spacingMd),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isCurrentUserInTeam
                    ? Theme.of(context).colorScheme.primary
                    : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
        ),
        child: Padding(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team Header
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: team.color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  const SizedBox(width: ThemeConstants.spacingMd),
                  Expanded(
                    child: Text(
                      team.name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: ThemeConstants.spacingMd),

              // Clue Giver Section
              Text(
                'Clue Giver',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: ThemeConstants.spacingSm),

              if (clueGiver != null) ...[
                Container(
                  padding: const EdgeInsets.all(ThemeConstants.spacingMd),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusMd,
                    ),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.psychology,
                        color: Theme.of(context).colorScheme.primary,
                        size: 20,
                      ),
                      const SizedBox(width: ThemeConstants.spacingSm),
                      Expanded(
                        child: Text(
                          clueGiver.name,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      if (isCurrentUserClueGiver)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: ThemeConstants.spacingSm,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'You',
                            style: Theme.of(
                              context,
                            ).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ] else ...[
                Container(
                  padding: const EdgeInsets.all(ThemeConstants.spacingMd),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusMd,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.warning,
                        color: Theme.of(context).colorScheme.error,
                        size: 20,
                      ),
                      const SizedBox(width: ThemeConstants.spacingSm),
                      Text(
                        'No clue giver assigned',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: ThemeConstants.spacingMd),

              // Team Players
              Text(
                'Team Members (${teamPlayers.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: ThemeConstants.spacingSm),
              ...teamPlayers.map(
                (player) => _buildPlayerTile(player, clueGiver, currentUser),
              ),
              const SizedBox(height: ThemeConstants.spacingMd),

              // Change Clue Giver Button (if in this team)
              if (isCurrentUserInTeam &&
                  currentUser != null &&
                  !isCurrentUserClueGiver)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => _assignClueGiver(team.id, currentUser.id),
                    icon: const Icon(Icons.psychology),
                    label: const Text('Become Clue Giver'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: team.color,
                      side: BorderSide(color: team.color),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerTile(User player, User? clueGiver, User? currentUser) {
    final isCurrentUser = player.id == currentUser?.id;
    final isClueGiver = player.id == clueGiver?.id;

    return Container(
      margin: const EdgeInsets.only(bottom: ThemeConstants.spacingXs),
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.spacingMd,
        vertical: ThemeConstants.spacingSm,
      ),
      decoration: BoxDecoration(
        color:
            isClueGiver
                ? Theme.of(context).colorScheme.primaryContainer
                : isCurrentUser
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            isClueGiver ? Icons.psychology : Icons.person,
            size: 16,
            color:
                isClueGiver
                    ? Theme.of(context).colorScheme.primary
                    : isCurrentUser
                    ? Theme.of(context).colorScheme.onSecondaryContainer
                    : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const SizedBox(width: ThemeConstants.spacingSm),
          Expanded(
            child: Text(
              player.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight:
                    isCurrentUser || isClueGiver
                        ? FontWeight.w600
                        : FontWeight.normal,
              ),
            ),
          ),
          if (isClueGiver)
            Icon(
              Icons.star,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
        ],
      ),
    );
  }

  void _assignClueGiver(String teamId, String playerId) {
    ref
        .read(gameNotifierProvider.notifier)
        .assignManualClueGiver(widget.gameId, teamId, playerId);
  }

  void _continueToGame() async {
    setState(() => _isAssigning = true);

    try {
      await ref
          .read(gameNotifierProvider.notifier)
          .assignClueGivers(widget.gameId);

      if (mounted) {
        // Navigate to noun selection (placeholder for now)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Game ready! Noun selection coming soon...'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to assign clue givers: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isAssigning = false);
      }
    }
  }
}
