import 'dart:async';
import '../game.dart';
import '../../../auth/domain/user.dart';

abstract class GameRepository {
  Future<Game> createGame(Game game);
  Future<Game?> getGameByJoinCode(String joinCode);
  Future<Game> joinGame(String joinCode, User user);
  Future<void> leaveGame(String gameId, String userId);
  Future<void> updateGameStatus(String gameId, GameStatus status);
  Stream<Game> watchGame(String gameId);
  Future<List<Game>> getUserGames(String userId);
  Future<void> deleteGame(String gameId);
}
