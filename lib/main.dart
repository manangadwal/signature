import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/screens/login_screen.dart';
import 'package:signature/screens/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        home: LoginScreen(),
        theme: ThemeData.dark().copyWith(
          colorScheme: ThemeData.dark().colorScheme.copyWith(
                secondary: Colors.red,
              ),
        ),
        initialRoute: MyRoutes.loginRoute,
        routes: routes);
  }
}
