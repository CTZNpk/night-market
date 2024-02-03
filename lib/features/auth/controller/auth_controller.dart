import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/auth/repository/auth_repository.dart';


final authControllerProvider = Provider((ref) {
  final myRepository = AuthRespository();
  return AuthController(authRepository: myRepository);
});

class AuthController {
  AuthController({required this.authRepository});

  AuthRespository authRepository;

  Future signingInWithEmailAndPassword(
      {required String email,
      required String password,
      Function? setError}) async {
    await authRepository.signingInWithEmailAndPassword(
        email: email, password: password, setError: setError);
  }

  Future creatingUserWithEmailPassword(
      {required String email,
      required String password,
      Function? setError}) async {
    await authRepository.creatingUserWithEmailAndPassword(
        email: email, password: password, setError: setError);
  }

  Future signingInWithGoogle() async {
    await authRepository.signingInWithGoogle();
  }

  Future signingOut() async {
    await authRepository.signingOut();
  }
}
