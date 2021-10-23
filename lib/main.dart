import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/screens/login_screen.dart';
import 'package:signature/screens/routes.dart';

import 'screens/homepage.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        home: auth.currentUser != null ? const Home() : const LoginScreen(),
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.red,
            accentColor: Colors.red),
        routes: routes);
  }
}
