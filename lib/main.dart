import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/auth/login_screen.dart';
import 'package:signature/meta/Utility/Constants.dart';
import 'package:signature/screens/bottom_navbar.dart';
import 'package:signature/screens/routes.dart';

import 'auth/auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPreferences.getInstance().then((prefs) async {
    bool localAuth = prefs.getBool("localAuth") ?? false;
    if (localAuth && !kIsWeb) {
      bool supportsFingerprint = await Localauth.hasBiometrics();
      if (supportsFingerprint) {
        final isAuthenticated = await Localauth.authenticate();
        if (isAuthenticated) {
          runApp(const MyApp());
        } else {
          SystemNavigator.pop();
        }
      } else {
        runApp(const MyApp());
      }
    } else {
      runApp(const MyApp());
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        home: auth.currentUser != null
            ? const BottomNavBar()
            : const LoginScreen(),
        theme: ThemeData(
            scaffoldBackgroundColor: bgColor,
            primaryColor: primaryColor,
            colorScheme: ColorScheme.fromSwatch(
              brightness: Brightness.dark,
            ).copyWith(
              secondary: primaryColor,
            )),
        routes: routes);
  }
}
