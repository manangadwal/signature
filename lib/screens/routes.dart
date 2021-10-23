import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/auth/login_screen.dart';
import 'package:signature/screens/homepage.dart';

// bool switchValue = false;

// class slide extends StatefulWidget {
//   const slide({Key? key}) : super(key: key);
//   @override
//   _slideState createState() => _slideState();
// }

// class _slideState extends State<slide> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: CupertinoSwitch(
//         activeColor: Colors.red,
//         value: switchValue,
//         onChanged: (value) {
//           setState(() {
//             switchValue = false;
//           });
//         },
//       ),
//     );
//   }
// }

final Map<String, Widget Function(BuildContext)> routes = {
  MyRoutes.homeRoute: (context) => Home(),
  MyRoutes.loginRoute: (context) => LoginScreen()
};

class MyRoutes {
  static String loginRoute = "/login";
  static String homeRoute = "/home";
}
