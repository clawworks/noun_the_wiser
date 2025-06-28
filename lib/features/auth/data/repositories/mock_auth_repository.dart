import 'dart:async';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/user.dart';
import '../../../../core/errors/failures.dart';

class MockAuthRepository implements AuthRepository {
  User? _currentUser;
  final StreamController<User?> _authStateController =
      StreamController<User?>.broadcast();

  @override
  Future<User?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<User> signInAnonymously({required String name}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final user = User.create(name: name, isAnonymous: true);

    _currentUser = user;
    _authStateController.add(user);

    return user;
  }

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final user = User.create(
      name: email.split('@').first,
      email: email,
      isAnonymous: false,
    );

    _currentUser = user;
    _authStateController.add(user);

    return user;
  }

  @override
  Future<User> createAccountWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final user = User.create(name: name, email: email, isAnonymous: false);

    _currentUser = user;
    _authStateController.add(user);

    return user;
  }

  @override
  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    _currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<User> updateUserProfile({String? name, String? email}) async {
    if (_currentUser == null) {
      throw AuthFailure('No user signed in');
    }

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final updatedUser = _currentUser!.copyWith(
      name: name ?? _currentUser!.name,
      email: email ?? _currentUser!.email,
    );

    _currentUser = updatedUser;
    _authStateController.add(updatedUser);

    return updatedUser;
  }

  @override
  Stream<User?> get authStateChanges {
    return _authStateController.stream;
  }

  void dispose() {
    _authStateController.close();
  }
}
