import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/game.dart';
import '../../../auth/domain/user.dart';

class GameLogicService {
  static const List<String> _defaultQuestions = [
    "If you were a HOUSEHOLD ITEM, what would you be?",
    "If you were a GAME, what would you be?",
    "If you were a FOOD, what would you be?",
    "If you were a COLOR, what would you be?",
    "If you were a SONG, what would you be?",
    "If you were a MOVIE, what would you be?",
    "If you were a BOOK, what would you be?",
    "If you were a SPORT, what would you be?",
    "If you were a WEATHER, what would you be?",
    "If you were a PROFESSION, what would you be?",
  ];

  static const Map<NounCategory, List<String>> _defaultNouns = {
    NounCategory.person: [
      "Abraham Lincoln",
      "Albert Einstein",
      "Marilyn Monroe",
      "Elvis Presley",
      "Michael Jackson",
      "Princess Diana",
      "Walt Disney",
      "Steve Jobs",
      "Oprah Winfrey",
      "Barack Obama",
    ],
    NounCategory.place: [
      "New York City",
      "Paris",
      "Tokyo",
      "London",
      "Rome",
      "Sydney",
      "Las Vegas",
      "Disney World",
      "Mount Everest",
      "The Grand Canyon",
    ],
    NounCategory.thing: [
      "The Beatles",
      "Star Wars",
      "Harry Potter",
      "The Godfather",
      "Coca-Cola",
      "McDonald's",
      "iPhone",
      "Facebook",
      "Google",
      "Netflix",
    ],
  };

  /// Assigns players to teams automatically
  static List<Team> assignTeamsToPlayers(List<User> players) {
    if (players.length < 2) {
      throw ArgumentError('Need at least 2 players to form teams');
    }

    final shuffledPlayers = List<User>.from(players)..shuffle();
    final team1Players =
        shuffledPlayers.take((shuffledPlayers.length / 2).ceil()).toList();
    final team2Players = shuffledPlayers.skip(team1Players.length).toList();

    final team1 = Team.create(
      name: 'Team 1',
      color: const Color(0xFF57CC02), // Green
    ).copyWith(playerIds: team1Players.map((p) => p.id).toList());

    final team2 = Team.create(
      name: 'Team 2',
      color: const Color(0xFF1CB0F6), // Blue
    ).copyWith(playerIds: team2Players.map((p) => p.id).toList());

    return [team1, team2];
  }

  /// Selects a random clue giver for each team
  static Map<String, String> selectClueGivers(List<Team> teams) {
    final clueGivers = <String, String>{};

    for (final team in teams) {
      if (team.playerIds.isNotEmpty) {
        final random = Random();
        final clueGiverId =
            team.playerIds[random.nextInt(team.playerIds.length)];
        clueGivers[team.id] = clueGiverId;
      }
    }

    return clueGivers;
  }

  /// Gets a random noun for the specified category
  static String getRandomNoun(NounCategory category) {
    final nouns = _defaultNouns[category] ?? [];
    if (nouns.isEmpty) {
      throw ArgumentError('No nouns available for category: $category');
    }

    final random = Random();
    return nouns[random.nextInt(nouns.length)];
  }

  /// Gets a random question from the question bank
  static String getRandomQuestion() {
    final random = Random();
    return _defaultQuestions[random.nextInt(_defaultQuestions.length)];
  }

  /// Checks if a guess is correct (case-insensitive)
  static bool isGuessCorrect(String guess, String correctNoun) {
    return guess.trim().toLowerCase() == correctNoun.toLowerCase();
  }

  /// Determines which team should go next based on game state
  static String? getNextTeamId(Game game) {
    if (game.teams.isEmpty) return null;

    // If no current team, start with the first team
    if (game.currentTeamId == null) {
      return game.teams.first.id;
    }

    // Find current team index
    final currentIndex = game.teams.indexWhere(
      (team) => team.id == game.currentTeamId,
    );
    if (currentIndex == -1) return game.teams.first.id;

    // Move to next team
    final nextIndex = (currentIndex + 1) % game.teams.length;
    return game.teams[nextIndex].id;
  }

  /// Checks if a team has won (has all three badges)
  static Team? getWinningTeam(List<Team> teams) {
    for (final team in teams) {
      if (team.badges.length >= 3) {
        return team;
      }
    }
    return null;
  }

  /// Gets the remaining categories for a team
  static List<NounCategory> getRemainingCategories(Team team) {
    final allCategories = NounCategory.values;
    return allCategories
        .where((category) => !team.badges.contains(category))
        .toList();
  }

  /// Validates if a clue follows the game rules
  static bool isValidClue(String clue, String noun, String question) {
    // Rule 1: Clue giver may not use any part of the actual name
    final nounWords = noun.toLowerCase().split(' ');
    final clueWords = clue.toLowerCase().split(' ');

    for (final nounWord in nounWords) {
      if (clueWords.contains(nounWord)) {
        return false;
      }
    }

    // Rule 2: Clue must be a logical response to the question
    // This is a simplified check - in practice, this would need more sophisticated validation
    if (clue.trim().isEmpty) {
      return false;
    }

    return true;
  }

  /// Calculates remaining time for current turn
  static int getRemainingTime(Game game) {
    if (game.turnStartTime == null || game.currentTurn == null) {
      return game.turnTimeLimit;
    }

    final elapsed = DateTime.now().difference(game.turnStartTime!).inSeconds;
    final remaining = game.turnTimeLimit - elapsed;
    return remaining > 0 ? remaining : 0;
  }

  /// Checks if the current turn has timed out
  static bool isTurnTimedOut(Game game) {
    return getRemainingTime(game) <= 0;
  }

  /// Gets all available questions
  static List<String> getAllQuestions() {
    return List.unmodifiable(_defaultQuestions);
  }

  /// Gets all available nouns for a category
  static List<String> getAllNounsForCategory(NounCategory category) {
    return List.unmodifiable(_defaultNouns[category] ?? []);
  }
}
