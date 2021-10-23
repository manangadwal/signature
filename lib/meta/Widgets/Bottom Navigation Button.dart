import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Utility/Constants.dart';

class BottomButton extends StatefulWidget {
  final String? text;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;
  const BottomButton({Key? key, this.onPressed, this.text, this.padding})
      : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 55,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primaryColor, // background
            onPrimary: Colors.white, // foreground
          ),
          onPressed: widget.onPressed,
          child: Text(
            widget.text ?? "Done",
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ));
  }
}
