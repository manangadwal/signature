import 'package:flutter/material.dart';
import 'package:signature/screens/auth.dart';
import 'package:signature/screens/homepage.dart';

class Auth_inside extends StatelessWidget {
  const Auth_inside({Key? key}) : super(key: key);

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
                        final isAuthenticated = await Localauth.authenticate();

                        if (isAuthenticated) {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, a1, a2) => home()));
                        }
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
