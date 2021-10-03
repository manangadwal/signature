import 'package:flutter/material.dart';
import 'package:signature/screens/generate.dart';
import 'package:signature/screens/routes.dart';
import 'package:signature/screens/saved.dart';
import 'package:flutter/cupertino.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [Icon(Icons.lock), slide()],
            title: Text(
              "Welcome",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // backgroundColor: Colors.cyan,
            // centerTitle: true,
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
            children: [generator(), saved()],
          ),
        ),
      ),
    );
  }
}
