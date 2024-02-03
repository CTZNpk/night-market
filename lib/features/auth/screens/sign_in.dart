import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:night_market/features/auth/controller/auth_controller.dart';
import 'package:night_market/shared/constants.dart';
import 'package:night_market/shared/widgets/loading.dart';



class SignIn extends ConsumerStatefulWidget {
  final Function toggle;
  const SignIn({super.key, required this.toggle});

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  void getPassword(String val) => password = val;
  void getEmail(String val) => email = val;

  void setErrorOnScreen(String er) {
    setState(
      () {
        loading = false;
        error = er;
      },
    );
  }

  Future onButtonPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() => loading = true);
      await ref.read(authControllerProvider).signingInWithEmailAndPassword(
          email: email, password: password, setError: setErrorOnScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);

    return loading
        ? const Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: myTheme.colorScheme.background,
            appBar: MyAuthenticateAppBar(
              title: 'Sign In Page',
              actions: [
                TextButton.icon(
                  onPressed: () => widget.toggle(),
                  icon: const Icon(Icons.person),
                  label: const Text('Register'),
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
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: LoginForm(
                      hintText: 'Email',
                      getEmail: getEmail,
                      getPassword: getPassword,
                    ),
                  ),
                  verticalSpace,
                  AuthButtonAndError(
                    onButtonPressed: onButtonPressed,
                    error: error,
                    buttonText: 'Sign In',
                  ),
                  MyButton(
                    onPressed: () async {
                      loading = true;
                      await ref
                          .read(authControllerProvider)
                          .signingInWithGoogle();
                      loading = false;
                    },
                    label: 'Sign In with Google',
                    image:
                        'http://pngimg.com/uploads/google/google_PNG19635.png',
                  ),
                  verticalSpace,
                ],
              ),
            ),
          );
  }
}

class MyAuthenticateAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  const MyAuthenticateAppBar({super.key, required this.title, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
      ),
      elevation: 0.0,
      actions: actions,
      toolbarOpacity: 1.0,
    );
  }
}

class AuthButtonAndError extends StatelessWidget {
  final Function onButtonPressed;
  final String buttonText;
  final String error;

  const AuthButtonAndError({
    super.key,
    required this.onButtonPressed,
    required this.error,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyButton(onPressed: onButtonPressed, label: buttonText),
        verticalSpace,
        ShowIfError(
          error: error,
        ),
      ],
    );
  }
}

class ShowIfError extends StatelessWidget {
  final String error;
  const ShowIfError({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);
    if (error == '') {
      return const SizedBox.shrink();
    } else {
      return Column(
        children: [
          Text(
            error,
            style: myTheme.textTheme.labelLarge
                ?.copyWith(color: myTheme.colorScheme.error),
          ),
          verticalSpace,
        ],
      );
    }
  }
}

class LoginForm extends StatelessWidget {
  final Function getEmail;
  final Function getPassword;
  final String hintText;
  const LoginForm({
    super.key,
    required this.hintText,
    required this.getEmail,
    required this.getPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace,
        LoginTextForm(
          label: hintText,
          getValue: getEmail,
          validator: (val) => val!.isEmpty ? 'Enter $hintText' : null,
        ),
        verticalSpace,
        LoginTextForm(
          validator: (val) => val!.length < 6
              ? 'Password should be greater than 6 characters'
              : null,
          label: 'Password',
          obscureText: true,
          getValue: getPassword,
        ),
      ],
    );
  }
}

class LoginTextForm extends StatelessWidget {
  final bool obscureText;
  final String label;
  final Function getValue;
  final Function? validator;
  const LoginTextForm({
    super.key,
    this.obscureText = false,
    required this.label,
    required this.getValue,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);
    return TextFormField(
      validator: (val) => validator!(val),
      obscureText: obscureText,
      style: TextStyle(color: myTheme.colorScheme.onSurface),
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: myTheme.colorScheme.surface,
        hintStyle: TextStyle(
          color: myTheme.colorScheme.onSurface,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: myTheme.colorScheme.outline,
            width: 2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: myTheme.colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      onChanged: (val) => getValue(val),
    );
  }
}

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String label;
  final String? image;
  final IconData? icon;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.image,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = Theme.of(context);
    return TextButton(
      onPressed: () => onPressed(),
      style: myTheme.textButtonTheme.style,
      child: SizedBox(
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShowIfImageOrIcon(image: image, icon: icon),
            const SizedBox(
              width: 4,
            ),
            Text(
              label,
              style: myTheme.textTheme.labelLarge
                  ?.copyWith(color: myTheme.colorScheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowIfImageOrIcon extends StatelessWidget {
  final String? image;
  final IconData? icon;
  const ShowIfImageOrIcon({super.key, required this.image, required this.icon});

  @override
  Widget build(BuildContext context) {
    if (image == null && icon == null) {
      return const SizedBox.shrink();
    } else if (image != null) {
      return Image.network(
        image!,
        height: 25,
      );
    } else {
      return Icon(icon!);
    }
  }
}
