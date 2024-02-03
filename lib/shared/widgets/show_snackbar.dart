import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String content}) {
  final myTheme = Theme.of(context); 
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
      backgroundColor: myTheme.colorScheme.primary,
    ),
  );
}
