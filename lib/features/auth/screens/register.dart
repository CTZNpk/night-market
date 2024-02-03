import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/auth/controller/auth_controller.dart';
import 'package:night_market/features/auth/screens/sign_in.dart';
import 'package:night_market/shared/constants.dart';
import 'package:night_market/shared/widgets/loading.dart';




class Register extends ConsumerStatefulWidget {
  final Function toggle;
  const Register({super.key, required this.toggle});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String confirmPassword = '';
  String error = '';

  void getEmail(String val) => email = val;
  void getPassword(String val) => password = val;
  void getConfirmPassword(String val) => confirmPassword = val;

  void setErrorOnScreen(String er) {
    setState(() {
      error = er;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);
    Future onButtonPressed() async {
      setErrorOnScreen('');
      if (_formKey.currentState!.validate()) {
        setState(() => loading = true);
        await ref.read(authControllerProvider).creatingUserWithEmailPassword(
            email: email, password: password, setError: setErrorOnScreen);
      }
    }

    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: myTheme.colorScheme.background,
            appBar: MyAuthenticateAppBar(
              title: 'Register Page',
              actions: [
                TextButton.icon(
                  onPressed: () => widget.toggle(),
                  icon: const Icon(Icons.person),
                  label: const Text('Sign In'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(myTheme.colorScheme.primary),
                    foregroundColor:
                        MaterialStatePropertyAll(myTheme.colorScheme.onSurface),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: applyPadding,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    LoginForm(
                    hintText: 'Email',
                      getEmail: getEmail,
                      getPassword: getPassword,
                    ),
                    verticalSpace,
                    LoginTextForm(
                      label: 'Confirm Password',
                      getValue: getConfirmPassword,
                      obscureText: true,
                      validator: (val) =>
                          val != password ? 'Passwords do not match' : null,
                    ),
                    verticalSpace,
                    AuthButtonAndError(
                      onButtonPressed: onButtonPressed,
                      error: error,
                      buttonText: 'Register',
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
