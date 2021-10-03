import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:signature/screens/homepage.dart';
import 'package:signature/screens/login_screen.dart';

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
  MyRoutes.homeRoute: (context) => home(),
  MyRoutes.loginRoute: (context) => login_screen()
};

class MyRoutes {
  static String loginRoute = "/login";
  static String homeRoute = "/home";
}
