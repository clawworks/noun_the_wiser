import 'package:riverpod/riverpod.dart';
import '../repositories/auth_repository.dart';
import '../user.dart';
import '../../presentation/providers/auth_providers.dart';

class SignInAnonymously {
  final AuthRepository repository;

  const SignInAnonymously(this.repository);

  Future<User> call({required String name}) async {
    return await repository.signInAnonymously(name: name);
  }
}

final signInAnonymouslyProvider = Provider<SignInAnonymously>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return SignInAnonymously(repository);
});
