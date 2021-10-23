import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/meta/Utility/constants.dart';
import 'package:signature/screens/generate.dart';
import 'package:signature/screens/saved.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getSharedPrefs();
  }

  getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: bgColor,
            centerTitle: true,
            title: Text.rich(
              TextSpan(
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 20),
                children: [
                  const TextSpan(
                    text: 'GET',
                  ),
                  TextSpan(
                    text: 'PASS',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ],
              ),
            ),
            bottom: const TabBar(
              indicatorColor: primaryColor,
              tabs: [
                Tab(
                  child: Text("Generator"),
                ),
                Tab(
                  child: Text("Saved"),
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [Generator(), Saved()],
          ),
        ),
      ),
    );
  }
}
