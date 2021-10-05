import 'package:flutter/material.dart';

class textForm extends StatelessWidget {
  final String name;
  final String desc;
  final ValueChanged<String>? onChangedName;
  final ValueChanged<String>? onChangedDesc;
  final VoidCallback? onSavedForm;

  const textForm({
    Key? key,
    this.name = '',
    this.desc = '',
    @required this.onChangedName,
    @required this.onChangedDesc,
    @required this.onSavedForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildName(),
          buildDesc(),
          SizedBox(
            height: 10,
          ),
          IconButton(onPressed: onSavedForm, icon: Icon(Icons.check))
        ],
      ),
    );
  }

  Widget buildName() {
    return TextFormField(
      onChanged: onChangedName,
      decoration: InputDecoration(
          // focusColor: Colors.red,
          // fillColor: Colors.red,
          border: UnderlineInputBorder(),
          label: Text("Password")),
    );
  }

  Widget buildDesc() {
    return TextFormField(
      onChanged: onChangedDesc,
      decoration: InputDecoration(
          // focusColor: Colors.red,
          // fillColor: Colors.red,
          border: UnderlineInputBorder(),
          label: Text("Description")),
    );
  }
}
