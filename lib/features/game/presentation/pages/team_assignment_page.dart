import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../domain/game.dart';
import '../providers/game_providers.dart';
import '../../../auth/domain/user.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import 'clue_giver_selection_page.dart';

class TeamAssignmentPage extends ConsumerStatefulWidget {
  final String gameId;

  const TeamAssignmentPage({super.key, required this.gameId});

  @override
  ConsumerState<TeamAssignmentPage> createState() => _TeamAssignmentPageState();
}

class _TeamAssignmentPageState extends ConsumerState<TeamAssignmentPage> {
  bool _isStarting = false;

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
              data:
                  (currentUser) =>
                      _buildTeamAssignmentContent(game, currentUser),
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

  Widget _buildTeamAssignmentContent(Game game, User? currentUser) {
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
                'Teams Assigned!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                'Players have been automatically assigned to teams. You can customize team colors and switch teams if needed.',
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

        // Teams List
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

              return _buildTeamCard(team, teamPlayers, game, currentUser);
            },
          ),
        ),

        // Start Game Button (only for host)
        if (isHost) ...[
          Container(
            padding: const EdgeInsets.all(ThemeConstants.spacingLg),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isStarting ? null : _startGame,
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
                    _isStarting
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
                          'Start Game',
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

  Widget _buildTeamCard(
    Team team,
    List<User> teamPlayers,
    Game game,
    User? currentUser,
  ) {
    final isCurrentUserInTeam = team.playerIds.contains(currentUser?.id);

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
                  if (isCurrentUserInTeam)
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: ThemeConstants.spacingMd),

              // Team Players
              Text(
                'Players (${teamPlayers.length})',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: ThemeConstants.spacingSm),
              ...teamPlayers.map(
                (player) => _buildPlayerTile(player, game, currentUser),
              ),
              const SizedBox(height: ThemeConstants.spacingMd),

              // Team Actions
              Row(
                children: [
                  // Color Picker
                  IconButton(
                    onPressed: () => _showColorPicker(team),
                    icon: const Icon(Icons.palette),
                    tooltip: 'Change team color',
                  ),
                  const SizedBox(width: ThemeConstants.spacingSm),

                  // Switch Team Button (if not in this team)
                  if (!isCurrentUserInTeam && currentUser != null)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _switchToTeam(team.id),
                        icon: const Icon(Icons.swap_horiz),
                        label: const Text('Join Team'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: team.color,
                          side: BorderSide(color: team.color),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayerTile(User player, Game game, User? currentUser) {
    final isCurrentUser = player.id == currentUser?.id;

    return Container(
      margin: const EdgeInsets.only(bottom: ThemeConstants.spacingXs),
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.spacingMd,
        vertical: ThemeConstants.spacingSm,
      ),
      decoration: BoxDecoration(
        color:
            isCurrentUser
                ? Theme.of(context).colorScheme.primaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
      ),
      child: Row(
        children: [
          Icon(
            Icons.person,
            size: 16,
            color:
                isCurrentUser
                    ? Theme.of(context).colorScheme.onPrimaryContainer
                    : Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
          const SizedBox(width: ThemeConstants.spacingSm),
          Expanded(
            child: Text(
              player.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: isCurrentUser ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
          if (isCurrentUser)
            Icon(
              Icons.check_circle,
              size: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
        ],
      ),
    );
  }

  void _showColorPicker(Team team) {
    final colors = [
      const Color(0xFF57CC02), // Green
      const Color(0xFF1CB0F6), // Blue
      const Color(0xFF6A5FE8), // Purple
      const Color(0xFFFFC702), // Yellow
      const Color(0xFFFF6B6B), // Red
      const Color(0xFFFF8E53), // Orange
      const Color(0xFF4ECDC4), // Teal
      const Color(0xFFA8E6CF), // Mint
    ];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Choose Team Color'),
            content: Wrap(
              spacing: ThemeConstants.spacingMd,
              runSpacing: ThemeConstants.spacingMd,
              children:
                  colors.map((color) {
                    final isSelected = team.color == color;
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        _changeTeamColor(team.id, color);
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color:
                                isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.transparent,
                            width: 3,
                          ),
                        ),
                        child:
                            isSelected
                                ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 24,
                                )
                                : null,
                      ),
                    );
                  }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
            ],
          ),
    );
  }

  void _changeTeamColor(String teamId, Color color) {
    ref
        .read(gameNotifierProvider.notifier)
        .changeTeamColor(widget.gameId, teamId, color);
  }

  void _switchToTeam(String teamId) {
    final currentUserAsync = ref.read(authNotifierProvider);
    final currentUser = currentUserAsync.value;
    if (currentUser != null) {
      ref
          .read(gameNotifierProvider.notifier)
          .switchPlayerTeam(widget.gameId, currentUser.id, teamId);
    }
  }

  void _startGame() async {
    setState(() => _isStarting = true);

    try {
      await ref.read(gameNotifierProvider.notifier).startGame(widget.gameId);

      if (mounted) {
        // Navigate to clue giver selection
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ClueGiverSelectionPage(gameId: widget.gameId),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start game: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isStarting = false);
      }
    }
  }
}
