import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/screens/generate.dart';
import 'package:signature/screens/saved.dart';
import 'package:signature/screens/settings.dart';

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
            actions: [
              IconButton(
                  onPressed: () => Get.to(() => Settings()),
                  icon: Icon(Icons.settings)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.logout),
              )
            ],
            title: const Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            bottom: const TabBar(
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
