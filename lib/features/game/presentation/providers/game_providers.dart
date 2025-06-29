import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../data/repositories/firebase_game_repository.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/game.dart';
import '../../domain/services/game_logic_service.dart';
import '../../../auth/domain/user.dart';
import '../../../../core/errors/failures.dart';

final gameRepositoryProvider = Provider<GameRepository>((ref) {
  try {
    // Check if Firebase is initialized
    Firebase.app();
    return FirebaseGameRepository();
  } catch (e) {
    // Firebase not available, use mock repository
    debugPrint('Using mock game repository: $e');
    throw UnimplementedError('Mock game repository not implemented yet');
  }
});

class GameNotifier extends StateNotifier<AsyncValue<Game?>> {
  final GameRepository repository;
  StreamSubscription<Game>? _gameSubscription;

  GameNotifier(this.repository) : super(const AsyncValue.data(null));

  void watchGame(String gameId) {
    _gameSubscription?.cancel();
    state = const AsyncValue.loading();

    _gameSubscription = repository
        .watchGame(gameId)
        .listen(
          (game) {
            state = AsyncValue.data(game);
          },
          onError: (error) {
            state = AsyncValue.error(error, StackTrace.current);
          },
        );
  }

  Future<void> createGame(Game game) async {
    state = const AsyncValue.loading();
    try {
      final createdGame = await repository.createGame(game);
      state = AsyncValue.data(createdGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> joinGame(String joinCode, User user) async {
    state = const AsyncValue.loading();
    try {
      final game = await repository.joinGame(joinCode, user);
      state = AsyncValue.data(game);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> leaveGame(String gameId, String userId) async {
    try {
      await repository.leaveGame(gameId, userId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateGameStatus(String gameId, GameStatus status) async {
    try {
      await repository.updateGameStatus(gameId, status);
      // The stream will automatically update the state
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // New Game Logic Methods

  /// Assigns players to teams and starts the game
  Future<void> startGame(String gameId) async {
    final game = state.value;
    if (game == null) {
      print('Error: No game found in state');
      return;
    }

    try {
      print('Starting game with ${game.players.length} players');

      // Assign teams using GameLogicService
      final teams = GameLogicService.assignTeamsToPlayers(game.players);
      print('Teams assigned: ${teams.length} teams');

      // Update game with teams and change status
      final updatedGame = game.copyWith(
        teams: teams,
        status: GameStatus.teamAssignment,
        phase: GamePhase.clueGiverSelection,
        startedAt: DateTime.now(),
      );
      print('Game updated, status: ${updatedGame.status}');

      await repository.updateGame(gameId, updatedGame);
      print('Game saved to repository');
    } catch (e, st) {
      print('Error in startGame: $e');
      print('Stack trace: $st');
      state = AsyncValue.error(e, st);
    }
  }

  /// Assigns clue givers for each team
  Future<void> assignClueGivers(String gameId) async {
    final game = state.value;
    if (game == null) return;

    try {
      final clueGivers = GameLogicService.selectClueGivers(game.teams);

      // Update teams with clue givers
      final updatedTeams =
          game.teams.map((team) {
            final clueGiverId = clueGivers[team.id];
            return clueGiverId != null
                ? team.copyWith(clueGiverId: clueGiverId)
                : team;
          }).toList();

      final updatedGame = game.copyWith(
        teams: updatedTeams,
        phase: GamePhase.nounSelection,
        status: GameStatus.inProgress,
      );

      await repository.updateGame(gameId, updatedGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Manually selects a clue giver for a specific team
  Future<void> selectClueGiver(
    String gameId,
    String teamId,
    String playerId,
  ) async {
    final game = state.value;
    if (game == null) return;

    try {
      // Update the specific team with the new clue giver
      final updatedTeams =
          game.teams.map((team) {
            if (team.id == teamId) {
              return team.copyWith(clueGiverId: playerId);
            }
            return team;
          }).toList();

      final updatedGame = game.copyWith(teams: updatedTeams);
      await repository.updateGame(gameId, updatedGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Selects a noun category and starts a new round
  Future<void> selectNounCategory(String gameId, NounCategory category) async {
    final game = state.value;
    if (game == null) return;

    try {
      final noun = GameLogicService.getRandomNoun(category);
      final question = GameLogicService.getRandomQuestion();
      final nextTeamId = GameLogicService.getNextTeamId(game);

      final updatedGame = game.copyWith(
        currentCategory: category,
        currentNoun: noun,
        currentQuestion: question,
        currentTeamId: nextTeamId,
        phase: GamePhase.questionSelection,
        currentRound: game.currentRound + 1,
      );

      await repository.updateGame(gameId, updatedGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Submits a clue from the clue giver
  Future<void> submitClue(String gameId, String clue) async {
    final game = state.value;
    if (game == null || game.currentNoun == null) return;

    try {
      // Validate the clue
      if (!GameLogicService.isValidClue(
        clue,
        game.currentNoun!,
        game.currentQuestion ?? '',
      )) {
        throw GameFailure('Invalid clue: Cannot use parts of the noun name');
      }

      final updatedGame = game.copyWith(
        currentClue: clue,
        phase: GamePhase.guessing,
        turnStartTime: DateTime.now(),
      );

      await repository.updateGame(gameId, updatedGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Submits a guess from a team
  Future<void> submitGuess(String gameId, String guess) async {
    final game = state.value;
    if (game == null || game.currentNoun == null) return;

    try {
      final isCorrect = GameLogicService.isGuessCorrect(
        guess,
        game.currentNoun!,
      );

      // Create a new turn record
      final turn = GameTurn.create(
        teamId: game.currentTeamId ?? '',
        clueGiverId: game.currentClueGiverId ?? '',
        category: game.currentCategory,
        noun: game.currentNoun!,
        question: game.currentQuestion ?? '',
        timeLimit: game.turnTimeLimit,
      ).copyWith(
        clue: game.currentClue,
        guess: guess,
        isCorrect: isCorrect,
        endTime: DateTime.now(),
      );

      if (isCorrect) {
        // Award badge to the team
        final updatedTeams =
            game.teams.map((team) {
              if (team.id == game.currentTeamId) {
                return team.copyWith(
                  badges: [...team.badges, game.currentCategory],
                  score: team.score + 1,
                );
              }
              return team;
            }).toList();

        // Check if team has won
        final winningTeam = GameLogicService.getWinningTeam(updatedTeams);

        final updatedGame = game.copyWith(
          teams: updatedTeams,
          turnHistory: [...game.turnHistory, turn],
          phase: winningTeam != null ? GamePhase.gameEnd : GamePhase.roundEnd,
          status:
              winningTeam != null ? GameStatus.finished : GameStatus.inProgress,
          endedAt: winningTeam != null ? DateTime.now() : null,
        );

        await repository.updateGame(gameId, updatedGame);
      } else {
        // Move to next team
        final nextTeamId = GameLogicService.getNextTeamId(game);
        final updatedGame = game.copyWith(
          currentTeamId: nextTeamId,
          turnHistory: [...game.turnHistory, turn],
          phase: GamePhase.questionSelection,
        );

        await repository.updateGame(gameId, updatedGame);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Switches a player to a different team
  Future<void> switchPlayerTeam(
    String gameId,
    String playerId,
    String newTeamId,
  ) async {
    final game = state.value;
    if (game == null) return;

    try {
      final updatedTeams =
          game.teams.map((team) {
            final hasPlayer = team.playerIds.contains(playerId);
            if (hasPlayer) {
              // Remove player from current team
              return team.copyWith(
                playerIds:
                    team.playerIds.where((id) => id != playerId).toList(),
              );
            } else if (team.id == newTeamId) {
              // Add player to new team
              return team.copyWith(playerIds: [...team.playerIds, playerId]);
            }
            return team;
          }).toList();

      final updatedGame = game.copyWith(teams: updatedTeams);
      await repository.updateGame(gameId, updatedGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Changes team color
  Future<void> changeTeamColor(
    String gameId,
    String teamId,
    Color color,
  ) async {
    final game = state.value;
    if (game == null) return;

    try {
      final updatedTeams =
          game.teams.map((team) {
            if (team.id == teamId) {
              return team.copyWith(color: color);
            }
            return team;
          }).toList();

      final updatedGame = game.copyWith(teams: updatedTeams);
      await repository.updateGame(gameId, updatedGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Manually assigns a clue giver (for when assigned one is offline)
  Future<void> assignManualClueGiver(
    String gameId,
    String teamId,
    String playerId,
  ) async {
    final game = state.value;
    if (game == null) return;

    try {
      final updatedTeams =
          game.teams.map((team) {
            if (team.id == teamId) {
              return team.copyWith(clueGiverId: playerId);
            }
            return team;
          }).toList();

      final updatedGame = game.copyWith(teams: updatedTeams);
      await repository.updateGame(gameId, updatedGame);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  @override
  void dispose() {
    _gameSubscription?.cancel();
    super.dispose();
  }
}

final gameNotifierProvider =
    StateNotifierProvider<GameNotifier, AsyncValue<Game?>>((ref) {
      final repository = ref.watch(gameRepositoryProvider);
      return GameNotifier(repository);
    });

final currentGameProvider = Provider<Game?>((ref) {
  return ref.watch(gameNotifierProvider).value;
});

final gamePlayersProvider = Provider<List<User>>((ref) {
  final game = ref.watch(currentGameProvider);
  return game?.players ?? [];
});

final gameStatusProvider = Provider<GameStatus?>((ref) {
  final game = ref.watch(currentGameProvider);
  return game?.status;
});

final gameTeamsProvider = Provider<List<Team>>((ref) {
  final game = ref.watch(currentGameProvider);
  return game?.teams ?? [];
});

final currentTeamProvider = Provider<Team?>((ref) {
  final game = ref.watch(currentGameProvider);
  final teams = game?.teams ?? [];
  final currentTeamId = game?.currentTeamId;

  if (currentTeamId == null || teams.isEmpty) return null;
  return teams.firstWhere((team) => team.id == currentTeamId);
});

final gamePhaseProvider = Provider<GamePhase?>((ref) {
  final game = ref.watch(currentGameProvider);
  return game?.phase;
});

final winningTeamProvider = Provider<Team?>((ref) {
  final teams = ref.watch(gameTeamsProvider);
  return GameLogicService.getWinningTeam(teams);
});
