import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../data/repositories/firebase_game_repository.dart';
import '../../domain/repositories/game_repository.dart';
import '../../domain/game.dart';
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
