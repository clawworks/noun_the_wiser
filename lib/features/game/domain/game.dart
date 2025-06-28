import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../auth/domain/user.dart';

part 'game.freezed.dart';
part 'game.g.dart';

class ColorJsonConverter implements JsonConverter<Color, int> {
  const ColorJsonConverter();
  @override
  Color fromJson(int json) => Color(json);
  @override
  int toJson(Color color) => color.toARGB32();
}

enum GameStatus { waiting, inProgress, finished }

enum GamePhase { teamSelection, clueGiving, guessing, roundEnd, gameEnd }

@freezed
class Game with _$Game {
  const factory Game({
    required String id,
    required String joinCode,
    @JsonKey(toJson: _userListToJson, fromJson: _userListFromJson)
    required List<User> players,
    required List<Team> teams,
    @Default(GameStatus.waiting) GameStatus status,
    @Default(GamePhase.teamSelection) GamePhase phase,
    @Default(1) int currentRound,
    String? currentClueGiverId,
    @Default('Person') String currentCategory,
    String? currentNoun,
    @Default([]) List<String> guessedNouns,
    @Default({}) Map<String, List<String>> teamScores,
    required DateTime createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  factory Game.create({required String joinCode, required User creator}) {
    return Game(
      id: const Uuid().v4(),
      joinCode: joinCode,
      players: [creator],
      teams: [],
      createdAt: DateTime.now(),
    );
  }
}

// Helper functions for JSON serialization of User lists
List<Map<String, dynamic>> _userListToJson(List<User> users) {
  return users.map((user) => user.toJson()).toList();
}

List<User> _userListFromJson(List<dynamic> json) {
  return json
      .map((item) => User.fromJson(item as Map<String, dynamic>))
      .toList();
}

@freezed
class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    required List<String> playerIds,
    String? clueGiverId,
    @Default([]) List<String> guessedNouns,
    @ColorJsonConverter() required Color color,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  factory Team.create({required String name, required Color color}) {
    return Team(id: const Uuid().v4(), name: name, playerIds: [], color: color);
  }
}
