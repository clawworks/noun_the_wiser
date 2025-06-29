import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_providers.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/game.dart';
import '../../../auth/domain/user.dart';
import '../../../../core/constants/theme_constants.dart';
import '../../domain/services/game_logic_service.dart';

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            // Dismiss keyboard when tapping outside text fields
            FocusScope.of(context).unfocus();
          },
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
        // Show different content based on game phase
        switch (game.phase) {
          case GamePhase.clueGiverSelection:
            return _buildClueGiverContent(game, currentUser);
          case GamePhase.nounSelection:
            return _buildNounSelectionContent(game, currentUser);
          case GamePhase.questionSelection:
            return _buildQuestionSelectionContent(game, currentUser);
          case GamePhase.clueGiving:
            return _buildClueGivingContent(game, currentUser);
          case GamePhase.guessing:
            return _buildGuessingContent(game, currentUser);
          case GamePhase.roundEnd:
            return _buildRoundEndContent(game, currentUser);
          case GamePhase.gameEnd:
            return _buildGameEndContent(game, currentUser);
          default:
            return _buildGameInProgressContent(game, currentUser);
        }

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
                onPressed: () => _continueToGame(),
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

  void _continueToGame() async {
    try {
      // The game will automatically move to the next phase based on the logic
      // This method is mainly for user interaction
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

  void _selectNoun(String noun) {
    ref.read(gameNotifierProvider.notifier).selectNoun(widget.gameId, noun);
  }

  Widget _buildNounSelectionContent(Game game, User? currentUser) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );
    final isCurrentUserClueGiver = currentTeam.clueGiverId == currentUser?.id;
    final currentClueGiver = game.players.firstWhere(
      (player) => player.id == currentTeam.clueGiverId,
      orElse: () => game.players.first,
    );

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              Text(
                'Noun Selection',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                '${currentClueGiver.name} is selecting a noun for ${currentTeam.name}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingSm),
              Text(
                'Choose a noun from any category:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: currentTeam.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Noun Selection
        if (isCurrentUserClueGiver) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select a noun for your team to guess:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Expanded(child: _buildAllNounsList(game, currentUser)),
                ],
              ),
            ),
          ),
        ] else ...[
          // Waiting for clue giver
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category, size: 64, color: currentTeam.color),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  Text(
                    'Waiting for ${currentClueGiver.name}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Text(
                    'to select a noun...',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildAllNounsList(Game game, User? currentUser) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );

    return ListView(
      children: [
        // Person Category
        _buildCategorySection(
          'Person',
          Icons.person,
          Colors.blue,
          GameLogicService.getNounsForCategory(NounCategory.person),
          game,
          currentUser,
        ),
        const SizedBox(height: ThemeConstants.spacingLg),

        // Place Category
        _buildCategorySection(
          'Place',
          Icons.location_on,
          Colors.green,
          GameLogicService.getNounsForCategory(NounCategory.place),
          game,
          currentUser,
        ),
        const SizedBox(height: ThemeConstants.spacingLg),

        // Thing Category
        _buildCategorySection(
          'Thing',
          Icons.category,
          Colors.orange,
          GameLogicService.getNounsForCategory(NounCategory.thing),
          game,
          currentUser,
        ),
      ],
    );
  }

  Widget _buildCategorySection(
    String categoryName,
    IconData icon,
    Color color,
    List<String> nouns,
    Game game,
    User? currentUser,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: ThemeConstants.spacingSm),
            Text(
              categoryName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: ThemeConstants.spacingMd),
        ...nouns.map((noun) => _buildNounCard(noun, game, currentUser)),
      ],
    );
  }

  Widget _buildNounCard(String noun, Game game, User? currentUser) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );

    return Card(
      margin: const EdgeInsets.only(bottom: ThemeConstants.spacingSm),
      child: InkWell(
        onTap: () => _selectNoun(noun),
        borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: currentTeam.color.withValues(alpha: 0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(ThemeConstants.spacingLg),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(ThemeConstants.spacingMd),
                  decoration: BoxDecoration(
                    color: currentTeam.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusMd,
                    ),
                  ),
                  child: Icon(
                    Icons.category,
                    color: currentTeam.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: ThemeConstants.spacingMd),
                Expanded(
                  child: Text(
                    noun,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: currentTeam.color,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameEndContent(Game game, User? currentUser) {
    final winningTeam = GameLogicService.getWinningTeam(game.teams);
    final isHost = game.players.first.id == currentUser?.id;

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              Text(
                'Game Over!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              if (winningTeam != null) ...[
                Text(
                  '${winningTeam.name} Wins!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: winningTeam.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: ThemeConstants.spacingSm),
                Text(
                  'Congratulations on collecting all three badges!',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else ...[
                Text(
                  'It\'s a tie!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),

        // Final Results
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ThemeConstants.spacingLg),
            child: Column(
              children: [
                // Final Scores
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(ThemeConstants.spacingLg),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusLg,
                    ),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Final Results',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: ThemeConstants.spacingMd),
                      ...game.teams.map((team) {
                        final isWinner = winningTeam?.id == team.id;
                        return Container(
                          margin: const EdgeInsets.only(
                            bottom: ThemeConstants.spacingMd,
                          ),
                          padding: const EdgeInsets.all(
                            ThemeConstants.spacingMd,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isWinner
                                    ? team.color.withValues(alpha: 0.1)
                                    : Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              ThemeConstants.radiusMd,
                            ),
                            border: Border.all(
                              color: isWinner ? team.color : Colors.transparent,
                              width: isWinner ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: team.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: ThemeConstants.spacingSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          team.name,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (isWinner) ...[
                                          const SizedBox(
                                            width: ThemeConstants.spacingSm,
                                          ),
                                          Icon(
                                            Icons.emoji_events,
                                            size: 20,
                                            color: team.color,
                                          ),
                                        ],
                                      ],
                                    ),
                                    const SizedBox(
                                      height: ThemeConstants.spacingXs,
                                    ),
                                    Text(
                                      '${team.score} points • ${team.badges.length} badges',
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyMedium?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withValues(alpha: 0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                const SizedBox(height: ThemeConstants.spacingLg),

                // Game Statistics
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(ThemeConstants.spacingLg),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusLg,
                    ),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Game Statistics',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: ThemeConstants.spacingMd),
                      _buildStatRow('Total Rounds', '${game.currentRound}'),
                      _buildStatRow(
                        'Total Turns',
                        '${game.turnHistory.length}',
                      ),
                      _buildStatRow(
                        'Game Duration',
                        _formatDuration(game.createdAt, game.endedAt),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Action Buttons
                if (isHost) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _startNewGame(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            ThemeConstants.radiusMd,
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Start New Game',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                ],
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () => _returnToLobby(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ThemeConstants.radiusMd,
                        ),
                      ),
                    ),
                    child: const Text(
                      'Return to Lobby',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: ThemeConstants.spacingSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  String _formatDuration(DateTime start, DateTime? end) {
    if (end == null) return 'In Progress';
    final duration = end.difference(start);
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes}m ${seconds}s';
  }

  void _startNewGame() {
    // TODO: Implement new game creation
    _returnToLobby();
  }

  void _returnToLobby() {
    Navigator.of(context).pop();
  }

  Widget _buildQuestionSelectionContent(Game game, User? currentUser) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );
    final isCurrentUserClueGiver = currentTeam.clueGiverId == currentUser?.id;
    final isCurrentUserInTeam = currentTeam.playerIds.contains(currentUser?.id);
    final currentClueGiver = game.players.firstWhere(
      (player) => player.id == currentTeam.clueGiverId,
      orElse: () => game.players.first,
    );

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              Text(
                'Question Selection',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                '${currentTeam.name} is selecting a question',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeConstants.spacingMd,
                  vertical: ThemeConstants.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: currentTeam.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  border: Border.all(color: currentTeam.color),
                ),
                child: Text(
                  'Noun: ${game.currentNoun}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: currentTeam.color,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Question Selection
        if (isCurrentUserInTeam && !isCurrentUserClueGiver) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose a question to help ${currentClueGiver.name} give clues:',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildQuestionCard(
                          'What is it?',
                          'Describe what the noun is or does',
                          Icons.question_mark,
                          game,
                          currentUser,
                        ),
                        const SizedBox(height: ThemeConstants.spacingMd),
                        _buildQuestionCard(
                          'Where is it?',
                          'Describe where you would find this noun',
                          Icons.location_on,
                          game,
                          currentUser,
                        ),
                        const SizedBox(height: ThemeConstants.spacingMd),
                        _buildQuestionCard(
                          'When is it?',
                          'Describe when this noun is relevant or used',
                          Icons.schedule,
                          game,
                          currentUser,
                        ),
                        const SizedBox(height: ThemeConstants.spacingMd),
                        _buildQuestionCard(
                          'Why is it?',
                          'Describe why this noun is important or useful',
                          Icons.psychology,
                          game,
                          currentUser,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ] else ...[
          // Waiting for team or clue giver waiting
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.psychology, size: 64, color: currentTeam.color),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  Text(
                    isCurrentUserClueGiver
                        ? 'Your team is selecting a question...'
                        : 'Waiting for ${currentTeam.name}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Text(
                    isCurrentUserClueGiver
                        ? 'Wait for them to choose a question'
                        : 'to select a question...',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildQuestionCard(
    String question,
    String description,
    IconData icon,
    Game game,
    User? currentUser,
  ) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );
    final isCurrentUserInTeam = currentTeam.playerIds.contains(currentUser?.id);
    final isCurrentUserClueGiver = currentTeam.clueGiverId == currentUser?.id;

    return Card(
      child: InkWell(
        onTap:
            (isCurrentUserInTeam && !isCurrentUserClueGiver)
                ? () => _selectQuestion(question)
                : null,
        borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: currentTeam.color.withValues(alpha: 0.3),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
          ),
          child: Padding(
            padding: const EdgeInsets.all(ThemeConstants.spacingLg),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(ThemeConstants.spacingMd),
                  decoration: BoxDecoration(
                    color: currentTeam.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusMd,
                    ),
                  ),
                  child: Icon(icon, color: currentTeam.color, size: 24),
                ),
                const SizedBox(width: ThemeConstants.spacingMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        question,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: ThemeConstants.spacingXs),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
                if (isCurrentUserInTeam && !isCurrentUserClueGiver)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: currentTeam.color,
                    size: 16,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectQuestion(String question) {
    ref
        .read(gameNotifierProvider.notifier)
        .selectQuestion(widget.gameId, question);
  }

  Widget _buildClueGivingContent(Game game, User? currentUser) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );
    final isCurrentUserClueGiver = currentTeam.clueGiverId == currentUser?.id;
    final currentClueGiver = game.players.firstWhere(
      (player) => player.id == currentTeam.clueGiverId,
      orElse: () => game.players.first,
    );

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              Text(
                'Clue Giving',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                '${currentClueGiver.name} is giving clues for ${currentTeam.name}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeConstants.spacingMd,
                  vertical: ThemeConstants.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: currentTeam.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  border: Border.all(color: currentTeam.color),
                ),
                child: Text(
                  'Noun: ${game.currentNoun}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: currentTeam.color,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Clue Input
        if (isCurrentUserClueGiver) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question: ${game.currentQuestion}',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Text(
                    'Give a clue that answers this question. Be creative but don\'t use parts of the noun name!',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  Expanded(child: _buildClueInput(game, currentUser)),
                ],
              ),
            ),
          ),
        ] else ...[
          // Waiting for clue giver
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit_note, size: 64, color: currentTeam.color),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  Text(
                    'Waiting for ${currentClueGiver.name}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Text(
                    'to give a clue...',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildClueInput(Game game, User? currentUser) {
    final TextEditingController clueController = TextEditingController();
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: TextField(
              controller: clueController,
              maxLines: null,
              minLines: 3,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Enter your clue here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  borderSide: BorderSide(color: currentTeam.color),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  borderSide: BorderSide(color: currentTeam.color, width: 2),
                ),
                filled: true,
                fillColor: currentTeam.color.withValues(alpha: 0.05),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        const SizedBox(height: ThemeConstants.spacingLg),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final clue = clueController.text.trim();
              if (clue.isNotEmpty) {
                _submitClue(clue);
                // Clear the text field after submission
                clueController.clear();
                // Dismiss keyboard
                FocusScope.of(context).unfocus();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: currentTeam.color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Submit Clue',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  void _submitClue(String clue) {
    ref.read(gameNotifierProvider.notifier).submitClue(widget.gameId, clue);
  }

  Widget _buildGuessingContent(Game game, User? currentUser) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );
    final isCurrentUserClueGiver = currentTeam.clueGiverId == currentUser?.id;
    final currentClueGiver = game.players.firstWhere(
      (player) => player.id == currentTeam.clueGiverId,
      orElse: () => game.players.first,
    );

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              Text(
                'Guessing Time!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                '${currentTeam.name} is guessing',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingSm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeConstants.spacingMd,
                  vertical: ThemeConstants.spacingSm,
                ),
                decoration: BoxDecoration(
                  color: currentTeam.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  border: Border.all(color: currentTeam.color),
                ),
                child: Text(
                  'Noun: ${game.currentNoun}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: currentTeam.color,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Clue Display
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: ThemeConstants.spacingLg,
          ),
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          decoration: BoxDecoration(
            color: currentTeam.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(ThemeConstants.radiusLg),
            border: Border.all(color: currentTeam.color.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              Text(
                'Question: ${game.currentQuestion}',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                'Clue: ${game.currentClue}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: currentTeam.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingSm),
              Text(
                'From: ${currentClueGiver.name}',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Guessing Interface
        if (!isCurrentUserClueGiver) ...[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(ThemeConstants.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What do you think the noun is?',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Text(
                    'Type your guess below:',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  Expanded(child: _buildGuessInput(game, currentUser)),
                ],
              ),
            ),
          ),
        ] else ...[
          // Clue giver waiting
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.psychology, size: 64, color: currentTeam.color),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  Text(
                    'Your team is guessing...',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingMd),
                  Text(
                    'Wait for them to submit their guess',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: ThemeConstants.spacingLg),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildGuessInput(Game game, User? currentUser) {
    final TextEditingController guessController = TextEditingController();
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: TextField(
              controller: guessController,
              maxLines: null,
              minLines: 3,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Enter your guess...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  borderSide: BorderSide(color: currentTeam.color),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
                  borderSide: BorderSide(color: currentTeam.color, width: 2),
                ),
                filled: true,
                fillColor: currentTeam.color.withValues(alpha: 0.05),
              ),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        const SizedBox(height: ThemeConstants.spacingLg),
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final guess = guessController.text.trim();
              if (guess.isNotEmpty) {
                _submitGuess(guess);
                // Clear the text field after submission
                guessController.clear();
                // Dismiss keyboard
                FocusScope.of(context).unfocus();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: currentTeam.color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeConstants.radiusMd),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Submit Guess',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }

  void _submitGuess(String guess) {
    ref.read(gameNotifierProvider.notifier).submitGuess(widget.gameId, guess);
  }

  Widget _buildRoundEndContent(Game game, User? currentUser) {
    final currentTeam = game.teams.firstWhere(
      (team) => team.id == game.currentTeamId,
      orElse: () => game.teams.first,
    );
    final lastTurn = game.turnHistory.isNotEmpty ? game.turnHistory.last : null;
    final isCorrect = lastTurn?.isCorrect ?? false;
    final guess = lastTurn?.guess ?? '';
    final noun = lastTurn?.noun ?? '';

    return Column(
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(ThemeConstants.spacingLg),
          child: Column(
            children: [
              Text(
                'Round ${game.currentRound} Results',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ThemeConstants.spacingMd),
              Text(
                currentTeam.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: currentTeam.color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Result Display
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(ThemeConstants.spacingLg),
            child: Column(
              children: [
                // Result Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(ThemeConstants.spacingLg),
                  decoration: BoxDecoration(
                    color:
                        isCorrect
                            ? Colors.green.withValues(alpha: 0.1)
                            : Colors.red.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusLg,
                    ),
                    border: Border.all(
                      color: isCorrect ? Colors.green : Colors.red,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        size: 64,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: ThemeConstants.spacingMd),
                      Text(
                        isCorrect ? 'Correct!' : 'Incorrect',
                        style: Theme.of(
                          context,
                        ).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: ThemeConstants.spacingMd),
                      Text(
                        'The noun was:',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: ThemeConstants.spacingSm),
                      Text(
                        noun,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: currentTeam.color,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (!isCorrect && guess.isNotEmpty) ...[
                        const SizedBox(height: ThemeConstants.spacingMd),
                        Text(
                          'Your guess was:',
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                        ),
                        const SizedBox(height: ThemeConstants.spacingSm),
                        Text(
                          guess,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: ThemeConstants.spacingLg),

                // Team Scores
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(ThemeConstants.spacingLg),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(
                      ThemeConstants.radiusLg,
                    ),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.outline.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Team Scores',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: ThemeConstants.spacingMd),
                      ...game.teams.map(
                        (team) => Padding(
                          padding: const EdgeInsets.only(
                            bottom: ThemeConstants.spacingSm,
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: team.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: ThemeConstants.spacingSm),
                              Expanded(
                                child: Text(
                                  team.name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              Text(
                                '${team.score} points',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: ThemeConstants.spacingLg),

                // Continue Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => _continueToNextRound(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: currentTeam.color,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ThemeConstants.radiusMd,
                        ),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      isCorrect
                          ? 'Continue to Next Round'
                          : 'Next Team\'s Turn',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _continueToNextRound() {
    // The game will automatically move to the next phase based on the logic in submitGuess
    // This button is mainly for user interaction and can trigger any additional logic if needed
  }
}
