import 'package:flutter/material.dart';

class TAppTheme {
  static final lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color.fromRGBO(255, 70, 85, 1),
      secondary: Colors.black,
      background: Colors.white,
      outline: Colors.black,
      surface: Colors.white,
      onSurface: Colors.black,
      error: Colors.red[900],
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: _textTheme,
    textButtonTheme: const MyButtonTheme(
      backgroundColor: Color.fromRGBO(255, 70, 85, 1),
      foregroundColor: Colors.white,
    ),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: const Color.fromRGBO(255, 70, 85, 1),
      secondary: Colors.grey,
      background: Colors.black,
      surface: Colors.black,
      outline: Colors.white,
      onSurface: Colors.white,
      error: Colors.red[900],
    ),
    scaffoldBackgroundColor: Colors.black,
    textTheme: _textTheme,
    textButtonTheme: const MyButtonTheme(
      backgroundColor: Color.fromRGBO(255, 70, 85, 1),
      foregroundColor: Colors.grey,
    ),
  );

  static const _textTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 25,
    ),
    labelLarge: TextStyle(fontSize: 14),
    displayMedium: TextStyle(fontSize: 18),
  );
}

class MyButtonTheme extends TextButtonThemeData {
  final Color? backgroundColor;
  final Color? foregroundColor;
  const MyButtonTheme(
      {required this.backgroundColor, required this.foregroundColor});

  @override
  ButtonStyle? get style => ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        foregroundColor: MaterialStatePropertyAll(foregroundColor),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );
}
