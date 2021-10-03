import 'package:flutter/material.dart';
import 'package:signature/screens/textform.dart';

class AddTodoDialogeWidget extends StatefulWidget {
  const AddTodoDialogeWidget({Key? key}) : super(key: key);

  @override
  _AddTodoDialogeWidgetState createState() => _AddTodoDialogeWidgetState();
}

class _AddTodoDialogeWidgetState extends State<AddTodoDialogeWidget> {
  final _formkey = GlobalKey<FormState>();
  String name = '';
  String desc = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Save Passwords',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          textForm(
            onChangedName: (name) => setState(() => this.name = name),
            onChangedDesc: (desc) => setState(() => this.desc = desc),
            onSavedForm: () {},
          )
        ],
      ),
    );
  }
}
