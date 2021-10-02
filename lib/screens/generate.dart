import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class generator extends StatefulWidget {
  const generator({Key? key}) : super(key: key);

  @override
  State<generator> createState() => _generatorState();
}

class _generatorState extends State<generator> {
  bool _hasBeenPressed = false;
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            " Random Password Generator ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: TextField(
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(Icons.copy),
                    onPressed: () {
                      final data = ClipboardData(text: controller.text);
                      Clipboard.setData(data);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Copied'),
                        backgroundColor: Colors.cyan,
                      ));
                    },
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(65)))),
              readOnly: true,
              enableInteractiveSelection: false,
              controller: controller,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.pressed)
                          ? Colors.cyan
                          : Colors.black)),
              onPressed: () {
                final password = generatepass();
                controller.text = password;
              },
              child: Text('Generate'))
        ],
      ),
    );
  }

  String generatepass() {
    final length = 15;
    final letterslower = 'abcdefghijklmnopqrstuvwxyz';
    final lettersupper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '1234567890';
    final special = '!#()*+,-./:;<=>?@[\]^_`{|}~%';

    String chars = '';
    chars += '$letterslower';
    chars += '$lettersupper';
    chars += '$numbers';
    chars += '$special';

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);

      return chars[indexRandom];
    }).join('');
  }
}
