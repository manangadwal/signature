import 'package:flutter/material.dart';

class Saved extends StatelessWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Center(child: Text('Save Password')),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          decoration: InputDecoration(label: Text("Title")),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          decoration: InputDecoration(label: Text("Password")),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: IconButton(
                              splashColor: Colors.red,
                              onPressed: () {},
                              icon: Icon(Icons.check))),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        splashColor: Colors.red,
      ),
    );
  }
}
