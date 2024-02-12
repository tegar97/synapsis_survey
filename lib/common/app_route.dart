import 'package:flutter/material.dart';
import 'package:synapsis_survey/features/auth/presentation/pages/login_page.dart';
import 'package:synapsis_survey/features/survey/presentation/pages/home_page.dart';

class AppRoute {
  static const login = "/login";
  static const home = "/home";

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case home:
        return MaterialPageRoute(builder: (context) => HomePage());
    }
  }

  static MaterialPageRoute get _notFoundPage => MaterialPageRoute(
      builder: (context) => const Scaffold(
            body: Center(
              child: Text("Page Not Found"),
            ),
          ));
}
