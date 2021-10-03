import 'package:flutter/material.dart';
import 'package:signature/screens/login_screen.dart';
import 'package:signature/screens/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: login_screen(),
        theme: ThemeData(brightness: Brightness.dark, accentColor: Colors.red),
        initialRoute: MyRoutes.loginRoute,
        routes: routes);
  }
}
