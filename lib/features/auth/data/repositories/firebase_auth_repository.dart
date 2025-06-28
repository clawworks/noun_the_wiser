import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/user.dart';
import '../../../../core/errors/failures.dart';

class FirebaseAuthRepository implements AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  FirebaseAuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<User?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      // Get user data from Firestore
      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (!userDoc.exists) return null;

      return User.fromJson(userDoc.data()!);
    } catch (e) {
      throw AuthFailure('Failed to get current user: $e');
    }
  }

  @override
  Future<User> signInAnonymously({required String name}) async {
    try {
      final credential = await _firebaseAuth.signInAnonymously();
      final firebaseUser = credential.user;

      if (firebaseUser == null) {
        throw AuthFailure('Failed to sign in anonymously');
      }

      // Create user document in Firestore
      final user = User.create(name: name, isAnonymous: true);

      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());

      return user.copyWith(id: firebaseUser.uid);
    } catch (e) {
      throw AuthFailure('Failed to sign in anonymously: $e');
    }
  }

  @override
  Future<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw AuthFailure('Failed to sign in with email and password');
      }

      // Get user data from Firestore
      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      if (!userDoc.exists) {
        throw AuthFailure('User document not found');
      }

      return User.fromJson(userDoc.data()!);
    } catch (e) {
      throw AuthFailure('Failed to sign in with email and password: $e');
    }
  }

  @override
  Future<User> createAccountWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw AuthFailure('Failed to create account');
      }

      // Create user document in Firestore
      final user = User.create(name: name, email: email, isAnonymous: false);

      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .set(user.toJson());

      return user.copyWith(id: firebaseUser.uid);
    } catch (e) {
      throw AuthFailure('Failed to create account: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthFailure('Failed to sign out: $e');
    }
  }

  @override
  Future<User> updateUserProfile({String? name, String? email}) async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) {
        throw AuthFailure('No user signed in');
      }

      // Update Firestore document
      final updates = <String, dynamic>{};
      if (name != null) updates['name'] = name;
      if (email != null) updates['email'] = email;

      await _firestore
          .collection('users')
          .doc(firebaseUser.uid)
          .update(updates);

      // Get updated user data
      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();

      return User.fromJson(userDoc.data()!);
    } catch (e) {
      throw AuthFailure('Failed to update user profile: $e');
    }
  }

  @override
  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((firebaseUser) async {
      if (firebaseUser == null) return null;

      try {
        final userDoc =
            await _firestore.collection('users').doc(firebaseUser.uid).get();

        if (!userDoc.exists) return null;

        return User.fromJson(userDoc.data()!);
      } catch (e) {
        return null;
      }
    });
  }
}
