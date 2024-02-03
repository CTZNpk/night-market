import 'package:flutter/material.dart';
import 'package:night_market/features/home/screens/search_screen.dart';
import 'package:night_market/features/home/screens/valorant_sign_in.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ValorantSignIn.routeName:
      return MaterialPageRoute(
        builder: (context) => const ValorantSignIn(),
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('This Page Does not Exist'),
          ),
        ),
      );
  }
}
