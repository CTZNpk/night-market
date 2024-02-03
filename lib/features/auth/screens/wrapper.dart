import 'package:flutter/material.dart';
import 'package:night_market/features/auth/screens/register.dart';
import 'package:night_market/features/auth/screens/sign_in.dart';



class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggle() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggle: toggle);
    } else {
      return Register(toggle:toggle);
    }
  }
}

