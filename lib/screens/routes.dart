import 'package:flutter/material.dart';
import 'package:signature/screens/authpage.dart';
import 'package:signature/screens/homepage.dart';
import 'package:signature/screens/login_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  MyRoutes.homeRoute: (context) => home(),
  MyRoutes.loginRoute: (context) => login_screen(),
};

class MyRoutes {
  static String loginRoute = "/login";
  static String homeRoute = "/home";
}
