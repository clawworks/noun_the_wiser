import '../user.dart';

abstract class AuthRepository {
  /// Get the current authenticated user
  Future<User?> getCurrentUser();

  /// Sign in anonymously
  Future<User> signInAnonymously({required String name});

  /// Sign in with email and password
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// Create account with email and password
  Future<User> createAccountWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  /// Sign out
  Future<void> signOut();

  /// Update user profile
  Future<User> updateUserProfile({String? name, String? email});

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges;
}
