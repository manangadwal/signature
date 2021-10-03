import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/screens/auth.dart';
import 'package:signature/screens/homepage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Colors.white,
        body: Container(
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "assets/s.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => states.contains(MaterialState.pressed)
                                  ? Colors.red
                                  : Colors.black)),
                      onPressed: () async {
                        var prefs = await SharedPreferences.getInstance();
                        bool localAuth = prefs.getBool("localAuth") ?? false;

                        if (localAuth) {
                          try {
                            final isAuthenticated =
                                await Localauth.authenticate();

                            if (isAuthenticated) {
                              Get.off(() => Home());
                            } else {
                              Get.snackbar(
                                  "Error", "Authentication Needed to continue");
                            }
                          } catch (e) {
                            Get.snackbar(
                                "Error", "Authentication Needed to continue");
                          }
                        } else
                          Get.off(() => Home());
                      },
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
