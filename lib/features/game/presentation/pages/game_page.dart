import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/game.dart';
import '../../../auth/domain/user.dart';
import '../../../../core/constants/theme_constants.dart';

class GamePage extends ConsumerStatefulWidget {
  final String gameId;

  const GamePage({super.key, required this.gameId});

  @override
  ConsumerState<GamePage> createState() => _GamePageState();
}

class _GamePageState extends ConsumerState<GamePage> {
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
              data: (currentUser) => _buildGameContent(game, currentUser),
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

  Widget _buildGameContent(Game game, User? currentUser) {
    // Show different content based on game status
    switch (game.status) {
      case GameStatus.waiting:
        return _buildLobbyContent(game, currentUser);

      case GameStatus.teamAssignment:
        return _buildTeamAssignmentContent(game, currentUser);

      case GameStatus.inProgress:
        // Show clue giver content when clue givers have been assigned (nounSelection phase)
        if (game.phase == GamePhase.nounSelection) {
          return _buildClueGiverContent(game, currentUser);
        }
        // For other phases, show a placeholder
        return _buildGameInProgressContent(game, currentUser);

      case GameStatus.finished:
        return _buildGameFinishedContent(game, currentUser);

      default:
        return _buildGameFinishedContent(game, currentUser);
    }
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
                onPressed: () => _assignClueGivers(game),
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
                child: const Text(
                  'Continue to Game',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildClueGiverContent(Game game, User? currentUser) {
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
                onPressed: () => _continueToGame(game),
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
                child: const Text(
                  'Continue to Game',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGameInProgressContent(Game game, User? currentUser) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_circle_outline,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Game in Progress',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Game phase: ${game.phase.name}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }

  Widget _buildGameFinishedContent(Game game, User? currentUser) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.emoji_events,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Game Finished!',
            style: Theme.of(
              context,
            ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Thanks for playing!',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Back to Home'),
          ),
        ],
      ),
    );
  }

  // Helper methods for lobby content
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

  // Helper methods for team assignment content
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

  // Helper methods for clue giver content
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

              // Clue Giver Selection
              if (teamPlayers.length > 1) ...[
                Text(
                  'Select Clue Giver',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: ThemeConstants.spacingSm),
                Wrap(
                  spacing: ThemeConstants.spacingSm,
                  runSpacing: ThemeConstants.spacingSm,
                  children:
                      teamPlayers.map((player) {
                        final isSelected = clueGiver?.id == player.id;
                        final isCurrentUser = player.id == currentUser?.id;

                        return GestureDetector(
                          onTap: () => _selectClueGiver(team.id, player.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: ThemeConstants.spacingMd,
                              vertical: ThemeConstants.spacingSm,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : isCurrentUser
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer
                                      : Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(
                                ThemeConstants.radiusMd,
                              ),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.psychology,
                                  size: 16,
                                  color:
                                      isSelected
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimary
                                          : isCurrentUser
                                          ? Theme.of(
                                            context,
                                          ).colorScheme.onPrimaryContainer
                                          : Theme.of(context)
                                              .colorScheme
                                              .onSurface
                                              .withValues(alpha: 0.7),
                                ),
                                const SizedBox(width: ThemeConstants.spacingXs),
                                Text(
                                  player.name,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.w600
                                            : FontWeight.normal,
                                    color:
                                        isSelected
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimary
                                            : isCurrentUser
                                            ? Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryContainer
                                            : Theme.of(
                                              context,
                                            ).colorScheme.onSurface,
                                  ),
                                ),
                                if (isCurrentUser) ...[
                                  const SizedBox(
                                    width: ThemeConstants.spacingXs,
                                  ),
                                  Text(
                                    '(You)',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodySmall?.copyWith(
                                      color:
                                          isSelected
                                              ? Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary
                                                  .withValues(alpha: 0.8)
                                              : Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Action methods
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

  Future<void> _startGame(Game game) async {
    try {
      print('Starting game: ${widget.gameId}');
      await ref.read(gameNotifierProvider.notifier).startGame(widget.gameId);
      print('Game started successfully');
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

  Future<void> _assignClueGivers(Game game) async {
    try {
      await ref
          .read(gameNotifierProvider.notifier)
          .assignClueGivers(widget.gameId);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to assign clue givers: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _continueToGame(Game game) async {
    try {
      // For now, just show a message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Game ready! Noun selection coming soon...'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to continue to game: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  void _showColorPicker(Team team) {
    showDialog(
      context: context,
      builder:
          (context) => Consumer(
            builder: (context, ref, child) {
              // Get current game to check which colors are already used
              final gameAsync = ref.watch(gameNotifierProvider);
              final game = gameAsync.value;
              final usedColors =
                  game?.teams
                      .where((t) => t.id != team.id) // Exclude current team
                      .map((t) => t.color)
                      .toSet() ??
                  <Color>{};

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

              return AlertDialog(
                title: const Text('Choose Team Color'),
                content: Wrap(
                  spacing: ThemeConstants.spacingMd,
                  runSpacing: ThemeConstants.spacingMd,
                  children:
                      colors.map((color) {
                        final isSelected = team.color == color;
                        final isUsed = usedColors.contains(color);

                        return GestureDetector(
                          onTap:
                              isUsed
                                  ? null
                                  : () {
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
                                    ? const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    )
                                    : isUsed
                                    ? const Icon(
                                      Icons.block,
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
              );
            },
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

  void _selectClueGiver(String teamId, String playerId) {
    ref
        .read(gameNotifierProvider.notifier)
        .selectClueGiver(widget.gameId, teamId, playerId);
  }
}
