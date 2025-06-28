import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart'; // Will add this dependency later
import 'user.dart';

enum GameStatus { waiting, inProgress, finished }

enum GamePhase { teamSelection, clueGiving, guessing, roundEnd, gameEnd }

class Game {
  final String id;
  final String joinCode;
  final List<User> players;
  final List<Team> teams;
  final GameStatus status;
  final GamePhase phase;
  final int currentRound;
  final String? currentClueGiverId;
  final String currentCategory;
  final String? currentNoun;
  final List<String> guessedNouns;
  final Map<String, List<String>> teamScores;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? endedAt;

  const Game({
    required this.id,
    required this.joinCode,
    required this.players,
    required this.teams,
    this.status = GameStatus.waiting,
    this.phase = GamePhase.teamSelection,
    this.currentRound = 1,
    this.currentClueGiverId,
    this.currentCategory = 'Person',
    this.currentNoun,
    this.guessedNouns = const [],
    this.teamScores = const {},
    required this.createdAt,
    this.startedAt,
    this.endedAt,
  });

  Game copyWith({
    String? id,
    String? joinCode,
    List<User>? players,
    List<Team>? teams,
    GameStatus? status,
    GamePhase? phase,
    int? currentRound,
    String? currentClueGiverId,
    String? currentCategory,
    String? currentNoun,
    List<String>? guessedNouns,
    Map<String, List<String>>? teamScores,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? endedAt,
  }) {
    return Game(
      id: id ?? this.id,
      joinCode: joinCode ?? this.joinCode,
      players: players ?? this.players,
      teams: teams ?? this.teams,
      status: status ?? this.status,
      phase: phase ?? this.phase,
      currentRound: currentRound ?? this.currentRound,
      currentClueGiverId: currentClueGiverId ?? this.currentClueGiverId,
      currentCategory: currentCategory ?? this.currentCategory,
      currentNoun: currentNoun ?? this.currentNoun,
      guessedNouns: guessedNouns ?? this.guessedNouns,
      teamScores: teamScores ?? this.teamScores,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'joinCode': joinCode,
      'players': players.map((p) => p.toJson()).toList(),
      'teams': teams.map((t) => t.toJson()).toList(),
      'status': status.name,
      'phase': phase.name,
      'currentRound': currentRound,
      'currentClueGiverId': currentClueGiverId,
      'currentCategory': currentCategory,
      'currentNoun': currentNoun,
      'guessedNouns': guessedNouns,
      'teamScores': teamScores,
      'createdAt': createdAt.toIso8601String(),
      'startedAt': startedAt?.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
    };
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      id: json['id'] as String,
      joinCode: json['joinCode'] as String,
      players:
          (json['players'] as List)
              .map((p) => User.fromJson(p as Map<String, dynamic>))
              .toList(),
      teams:
          (json['teams'] as List)
              .map((t) => Team.fromJson(t as Map<String, dynamic>))
              .toList(),
      status: GameStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => GameStatus.waiting,
      ),
      phase: GamePhase.values.firstWhere(
        (e) => e.name == json['phase'],
        orElse: () => GamePhase.teamSelection,
      ),
      currentRound: json['currentRound'] as int? ?? 1,
      currentClueGiverId: json['currentClueGiverId'] as String?,
      currentCategory: json['currentCategory'] as String? ?? 'Person',
      currentNoun: json['currentNoun'] as String?,
      guessedNouns: List<String>.from(json['guessedNouns'] ?? []),
      teamScores: Map<String, List<String>>.from(json['teamScores'] ?? {}),
      createdAt: DateTime.parse(json['createdAt'] as String),
      startedAt:
          json['startedAt'] != null
              ? DateTime.parse(json['startedAt'] as String)
              : null,
      endedAt:
          json['endedAt'] != null
              ? DateTime.parse(json['endedAt'] as String)
              : null,
    );
  }

  factory Game.create({required String joinCode, required User creator}) {
    return Game(
      id:
          DateTime.now().millisecondsSinceEpoch
              .toString(), // Temporary ID generation
      joinCode: joinCode,
      players: [creator],
      teams: [],
      createdAt: DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'Game(id: $id, status: $status, players: ${players.length})';
  }
}

class Team {
  final String id;
  final String name;
  final List<String> playerIds;
  final String? clueGiverId;
  final List<String> guessedNouns;
  final Color color;

  const Team({
    required this.id,
    required this.name,
    required this.playerIds,
    this.clueGiverId,
    this.guessedNouns = const [],
    required this.color,
  });

  Team copyWith({
    String? id,
    String? name,
    List<String>? playerIds,
    String? clueGiverId,
    List<String>? guessedNouns,
    Color? color,
  }) {
    return Team(
      id: id ?? this.id,
      name: name ?? this.name,
      playerIds: playerIds ?? this.playerIds,
      clueGiverId: clueGiverId ?? this.clueGiverId,
      guessedNouns: guessedNouns ?? this.guessedNouns,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'playerIds': playerIds,
      'clueGiverId': clueGiverId,
      'guessedNouns': guessedNouns,
      'color': color.value,
    };
  }

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'] as String,
      name: json['name'] as String,
      playerIds: List<String>.from(json['playerIds']),
      clueGiverId: json['clueGiverId'] as String?,
      guessedNouns: List<String>.from(json['guessedNouns'] ?? []),
      color: Color(json['color'] as int),
    );
  }

  factory Team.create({required String name, required Color color}) {
    return Team(
      id:
          DateTime.now().millisecondsSinceEpoch
              .toString(), // Temporary ID generation
      name: name,
      playerIds: [],
      color: color,
    );
  }

  @override
  String toString() {
    return 'Team(id: $id, name: $name, players: ${playerIds.length})';
  }
}
