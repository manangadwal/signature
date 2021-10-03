import 'package:flutter/material.dart';
import 'package:signature/screens/homepage.dart';
import 'package:signature/screens/routes.dart';

class login_screen extends StatelessWidget {
  const login_screen({Key? key}) : super(key: key);

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
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                                pageBuilder: (context, a1, a2) => home()));
                        // Navigator.of(context).pop();
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
