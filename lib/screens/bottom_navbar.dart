import 'package:flutter/material.dart';
import 'package:signature/meta/Utility/constants.dart';
import 'package:signature/screens/settings.dart';

import 'homepage.dart';

class BottomNavBar extends StatefulWidget {
  final int? index;
  const BottomNavBar({Key? key, this.index = 0}) : super(key: key);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [const Home(), Container(), Container(), Settings()];
    return Scaffold(
      body: tabs[index],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 20,
          type: BottomNavigationBarType.fixed,
          backgroundColor: bgColor,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          enableFeedback: true,
          iconSize: 20,
          selectedFontSize: 14,
          unselectedFontSize: 14,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security_update_warning),
              label: 'Tools',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }

  var navbarTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13);
}
