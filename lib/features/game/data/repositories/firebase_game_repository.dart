import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod/riverpod.dart';
import '../../domain/game.dart';
import '../../domain/repositories/game_repository.dart';
import '../../../auth/domain/user.dart';
import '../../../../core/errors/failures.dart';

class FirebaseGameRepository implements GameRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Game> createGame(Game game) async {
    try {
      // Convert the entire game to JSON to ensure proper serialization of nested User objects
      final gameData = game.toJson();
      await _firestore.collection('games').doc(game.id).set(gameData);
      return game;
    } catch (e) {
      throw GameFailure('Failed to create game: $e');
    }
  }

  @override
  Future<Game?> getGameByJoinCode(String joinCode) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('games')
              .where('joinCode', isEqualTo: joinCode)
              .where('status', isEqualTo: GameStatus.waiting.name)
              .limit(1)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      final doc = querySnapshot.docs.first;
      final data = doc.data();
      data['id'] = doc.id;
      return Game.fromJson(data);
    } catch (e) {
      throw GameFailure('Failed to get game by join code: $e');
    }
  }

  @override
  Future<Game> joinGame(String joinCode, User user) async {
    try {
      final game = await getGameByJoinCode(joinCode);
      if (game == null) {
        throw GameFailure('Game not found or already in progress');
      }

      // Check if user is already in the game
      if (game.players.any((player) => player.id == user.id)) {
        return game;
      }

      // Add user to the game
      final updatedPlayers = [...game.players, user];
      final updatedGame = game.copyWith(players: updatedPlayers);

      // Convert players to JSON for Firebase
      final playersJson = updatedPlayers.map((p) => p.toJson()).toList();

      await _firestore.collection('games').doc(game.id).update({
        'players': playersJson,
      });

      return updatedGame;
    } catch (e) {
      throw GameFailure('Failed to join game: $e');
    }
  }

  @override
  Future<void> leaveGame(String gameId, String userId) async {
    try {
      final gameDoc = await _firestore.collection('games').doc(gameId).get();
      if (!gameDoc.exists) {
        throw GameFailure('Game not found');
      }

      final game = Game.fromJson({...gameDoc.data()!, 'id': gameDoc.id});
      final updatedPlayers = game.players.where((p) => p.id != userId).toList();

      if (updatedPlayers.isEmpty) {
        // If no players left, delete the game
        await _firestore.collection('games').doc(gameId).delete();
      } else {
        // Update the game with remaining players
        final playersJson = updatedPlayers.map((p) => p.toJson()).toList();
        await _firestore.collection('games').doc(gameId).update({
          'players': playersJson,
        });
      }
    } catch (e) {
      throw GameFailure('Failed to leave game: $e');
    }
  }

  @override
  Future<void> updateGameStatus(String gameId, GameStatus status) async {
    try {
      await _firestore.collection('games').doc(gameId).update({
        'status': status.name,
      });
    } catch (e) {
      throw GameFailure('Failed to update game status: $e');
    }
  }

  @override
  Future<void> updateGame(String gameId, Game game) async {
    try {
      final gameData = game.toJson();
      await _firestore
          .collection('games')
          .doc(gameId)
          .set(gameData, SetOptions(merge: true));
    } catch (e) {
      throw GameFailure('Failed to update game: $e');
    }
  }

  @override
  Stream<Game> watchGame(String gameId) {
    return _firestore.collection('games').doc(gameId).snapshots().map((doc) {
      if (!doc.exists) {
        throw GameFailure('Game not found');
      }
      final data = doc.data()!;
      data['id'] = doc.id;
      return Game.fromJson(data);
    });
  }

  @override
  Future<List<Game>> getUserGames(String userId) async {
    try {
      // Get all games and filter by user ID since we can't query nested objects easily
      final querySnapshot =
          await _firestore
              .collection('games')
              .orderBy('createdAt', descending: true)
              .get();

      return querySnapshot.docs
          .map((doc) {
            final data = doc.data();
            data['id'] = doc.id;
            return Game.fromJson(data);
          })
          .where((game) => game.players.any((player) => player.id == userId))
          .toList();
    } catch (e) {
      throw GameFailure('Failed to get user games: $e');
    }
  }

  @override
  Future<void> deleteGame(String gameId) async {
    try {
      await _firestore.collection('games').doc(gameId).delete();
    } catch (e) {
      throw GameFailure('Failed to delete game: $e');
    }
  }
}
