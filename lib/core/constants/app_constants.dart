class AppConstants {
  static const String appName = 'Noun The Wiser';
  static const String appVersion = '1.0.0';

  // Game constants
  static const int maxPlayersPerTeam = 4;
  static const int minPlayersPerTeam = 2;
  static const int totalTeams = 2;
  static const int categoriesCount = 3;

  // Categories
  static const List<String> categories = ['Person', 'Place', 'Thing'];

  // Animation durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
}
