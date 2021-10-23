import 'package:flutter/material.dart';

class NoResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 3,
        child: Center(
            child: Text(
          "No Results Found",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        )));
  }
}
