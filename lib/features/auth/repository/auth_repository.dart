import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/auth/repository/sign_in_repository.dart';


final authRepositoryProvider = Provider((ref) => AuthRespository());

class AuthRespository {
  Future signingInWithEmailAndPassword(
      {required String email,
      required String password,
      Function? setError}) async {
    await EmailAndPasswordSignIn(
            email: email, password: password, setErrorOnScreen: setError)
        .signingIn();
  }

  Future signingInWithGoogle() async {
    await SignInWithGoogle().signingIn();
  }

  Future creatingUserWithEmailAndPassword(
      {required String email,
      required String password,
      Function? setError}) async {
    await EmailAndPasswordRegister(
            email: email, password: password, setErrorOnScreen: setError)
        .signingIn();
  }

  Future signingOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
