import 'package:flutter/material.dart';
import 'package:signature/screens/addtodo.dart';

class Saved extends StatelessWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              useSafeArea: true,
              context: context,
              builder: (BuildContext context) {
                return AddTodoDialogeWidget();
              },
              barrierDismissible: true),
          child: Icon(Icons.add),
          backgroundColor: Colors.black,
          splashColor: Colors.red,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
    );
  }
}
