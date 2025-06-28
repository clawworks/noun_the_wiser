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

enum GameStatus { waiting, teamAssignment, inProgress, finished }

enum GamePhase {
  teamSelection,
  clueGiverSelection,
  nounSelection,
  questionSelection,
  clueGiving,
  guessing,
  roundEnd,
  gameEnd,
}

enum NounCategory { person, place, thing }

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
    @Default(NounCategory.person) NounCategory currentCategory,
    String? currentNoun,
    String? currentQuestion,
    String? currentClue,
    String? currentClueGiverId,
    String? currentTeamId,
    @Default([]) List<String> guessedNouns,
    @Default({}) Map<String, List<String>> teamScores,
    @Default({}) Map<String, List<NounCategory>> teamBadges,
    @Default([]) List<GameTurn> turnHistory,
    GameTurn? currentTurn,
    @Default(60) int turnTimeLimit, // seconds
    DateTime? turnStartTime,
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

@freezed
class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    required List<String> playerIds,
    String? clueGiverId,
    @Default([]) List<String> guessedNouns,
    @Default([]) List<NounCategory> badges,
    @ColorJsonConverter() required Color color,
    @Default(0) int score,
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  factory Team.create({required String name, required Color color}) {
    return Team(id: const Uuid().v4(), name: name, playerIds: [], color: color);
  }
}

@freezed
class GameTurn with _$GameTurn {
  const factory GameTurn({
    required String id,
    required String teamId,
    required String clueGiverId,
    required NounCategory category,
    required String noun,
    required String question,
    String? clue,
    String? guess,
    bool? isCorrect,
    required DateTime startTime,
    DateTime? endTime,
    @Default(60) int timeLimit,
  }) = _GameTurn;

  factory GameTurn.fromJson(Map<String, dynamic> json) =>
      _$GameTurnFromJson(json);

  factory GameTurn.create({
    required String teamId,
    required String clueGiverId,
    required NounCategory category,
    required String noun,
    required String question,
    int timeLimit = 60,
  }) {
    return GameTurn(
      id: const Uuid().v4(),
      teamId: teamId,
      clueGiverId: clueGiverId,
      category: category,
      noun: noun,
      question: question,
      timeLimit: timeLimit,
      startTime: DateTime.now(),
    );
  }
}

@freezed
class Noun with _$Noun {
  const factory Noun({
    required String id,
    required String name,
    required NounCategory category,
    required String pack,
    @Default([]) List<String> tags,
  }) = _Noun;

  factory Noun.fromJson(Map<String, dynamic> json) => _$NounFromJson(json);
}

@freezed
class Question with _$Question {
  const factory Question({
    required String id,
    required String text,
    required String pack,
    @Default([]) List<String> tags,
  }) = _Question;

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
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
