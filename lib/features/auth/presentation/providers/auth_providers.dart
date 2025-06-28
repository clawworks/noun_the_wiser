import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../data/repositories/firebase_auth_repository.dart';
import '../../data/repositories/mock_auth_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  try {
    // Check if Firebase is initialized
    Firebase.app();
    return FirebaseAuthRepository();
  } catch (e) {
    // Firebase not available, use mock repository
    debugPrint('Using mock auth repository: $e');
    return MockAuthRepository();
  }
});

final authStateProvider = StreamProvider<User?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository repository;
  AuthNotifier(this.repository) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    try {
      final user = await repository.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signInAnonymously(String name) async {
    state = const AsyncValue.loading();
    try {
      final user = await repository.signInAnonymously(name: name);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await repository.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createAccountWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    state = const AsyncValue.loading();
    try {
      final user = await repository.createAccountWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signOut() async {
    try {
      await repository.signOut();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProfile({String? name, String? email}) async {
    try {
      final user = await repository.updateUserProfile(name: name, email: email);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
      final repository = ref.watch(authRepositoryProvider);
      return AuthNotifier(repository);
    });
