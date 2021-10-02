import 'package:flutter/material.dart';
import 'package:signature/screens/generate.dart';
import 'package:signature/screens/saved.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Welcome"),
            backgroundColor: Colors.cyan,
            centerTitle: true,
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
