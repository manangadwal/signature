import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:signature/meta/Utility/constants.dart';

class Generator extends StatefulWidget {
  const Generator({Key? key}) : super(key: key);

  @override
  State<Generator> createState() => _GeneratorState();
}

class _GeneratorState extends State<Generator> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Map filters = {
    "upper": true,
    "lower": true,
    "numbers": true,
    "symbols": true,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Random Password Generator ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Spacer(),
        GridView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2),
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                  activeColor: primaryColor,
                  value: filters["upper"],
                  onChanged: (value) {
                    setState(() {
                      filters["upper"] = value;
                    });
                  }),
              const Text("Upper Case"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                  activeColor: primaryColor,
                  value: filters["lower"],
                  onChanged: (value) {
                    setState(() {
                      filters["lower"] = value;
                    });
                  }),
              Text("Lower Case"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                  activeColor: primaryColor,
                  value: filters["numbers"],
                  onChanged: (value) {
                    setState(() {
                      filters["numbers"] = value;
                    });
                  }),
              Text("Numbers"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Checkbox(
                  activeColor: primaryColor,
                  value: filters["symbols"],
                  onChanged: (value) {
                    setState(() {
                      filters["symbols"] = value;
                    });
                  }),
              Text("Symbols"),
            ]),
          ],
        ),
        Spacer(),
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: TextField(
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: () {
                    final data = ClipboardData(text: controller.text);
                    Clipboard.setData(data);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Copied to clipboard',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      backgroundColor: primaryColor,
                    ));
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)))),
            readOnly: true,
            enableInteractiveSelection: false,
            controller: controller,
          ),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.all(20),
          child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) =>
                      states.contains(MaterialState.pressed)
                          ? primaryColor
                          : Colors.black)),
              onPressed: () {
                final password = generatepass(
                  lower: filters["lower"],
                  upper: filters["upper"],
                  number: filters["numbers"],
                  special: filters["symbols"],
                );
                controller.text = password;
              },
              child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Center(child: Text('Generate')))),
        )
      ],
    );
  }

  String generatepass(
      {bool lower = true,
      bool upper = true,
      bool number = true,
      bool special = true,
      int length = 15}) {
    if (!lower && !upper && !number && !special) {
      Get.dialog(AlertDialog(
        title: Text("Error"),
        content: Text("Please select at least one filter"),
        actions: [
          ElevatedButton(
            child: Text("Ok"),
            onPressed: () {
              Get.back();
            },
          )
        ],
      ));
      return "";
    }

    final letterslower = 'abcdefghijklmnopqrstuvwxyz';
    final lettersupper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final numbers = '1234567890';
    final specialChars = '!#()*+,-./:;<=>?@[\]^_`{|}~%';

    String chars = '';
    if (upper) chars += lettersupper;
    if (lower) chars += letterslower;
    if (number) chars += numbers;
    if (special) chars += specialChars;

    return List.generate(length, (index) {
      final indexRandom = Random.secure().nextInt(chars.length);
      return chars[indexRandom];
    }).join('');
  }
}
