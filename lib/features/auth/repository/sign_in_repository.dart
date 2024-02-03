import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

class AbstractSignIn {
  Function? setErrorOnScreen;
  AbstractSignIn({this.setErrorOnScreen});
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future checkAndReturnError(Function function) async {
    try {
      await function();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}


class EmailAndPasswordSignIn extends AbstractSignIn {
  String email, password;
  EmailAndPasswordSignIn(
      {super.setErrorOnScreen, required this.email, required this.password});

  @override
  Future checkAndReturnError(Function function) async {
    try {
      await function();
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        setErrorOnScreen!('No user found for that email');
      } else if (e.code == 'wrong-password') {
        setErrorOnScreen!('Wrong password provided for that user');
      } else if (e.code == 'invalid-email') {
        setErrorOnScreen!('Enter a Valid Email');
      }
      debugPrint(e.code);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signingIn() async {
    await checkAndReturnError(_signInWithEmailAndPassword);
  }

  Future _signInWithEmailAndPassword() async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }
}

class SignInWithGoogle {
  signingIn() async {
    final gUser = await _displayingSignInPage();
    final gAuth = await _obtainingDetails(gUser);
    await _signingInWithCredentials(_creatingCredentials(gAuth));
  }

  Future<GoogleSignInAccount?> _displayingSignInPage() async {
    return await GoogleSignIn().signIn();
  }

  Future<GoogleSignInAuthentication> _obtainingDetails(
      GoogleSignInAccount? gUser) async {
    return await gUser!.authentication;
  }

  _creatingCredentials(GoogleSignInAuthentication gAuth) {
    return GoogleAuthProvider.credential(
        idToken: gAuth.idToken, accessToken: gAuth.accessToken);
  }

  _signingInWithCredentials(AuthCredential credential) async {
    await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

class EmailAndPasswordRegister extends AbstractSignIn {
  String email, password;
  EmailAndPasswordRegister(
      {super.setErrorOnScreen, required this.email, required this.password});

  @override
  Future checkAndReturnError(Function function) async {
    try {
      await function();
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        setErrorOnScreen!('The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        setErrorOnScreen!('The account already exists for that email');
      } else if (e.code == 'invalid-email') {
        setErrorOnScreen!('Enter a Valid Email');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signingIn() async {
    await checkAndReturnError(_creatingWithEmailAndPassword);
  }

  Future _creatingWithEmailAndPassword() async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }
}
