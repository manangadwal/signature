import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/resources/SharedPrefs.dart';

final googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
SharedPref sharedPrefs = SharedPref();

unFocusKeyboard(context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) {
    currentFocus.unfocus();
  }
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')} Hr : ${parts[1].padLeft(2, '0')} Min';
}

String durationToWatchTime(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}:00';
}

List<dynamic> mapByKey(String keyName, List<dynamic> input) {
  Map returnValue = Map();
  for (var currMap in input) {
    if (currMap.containsKey(keyName)) {
      var currKeyValue = currMap[keyName];
      if (!returnValue.containsKey(currKeyValue)) {
        returnValue[currKeyValue] = {currKeyValue: []};
      }
      returnValue[currKeyValue][currKeyValue].add(currMap);
    }
  }
  return returnValue.values.toList();
}

textfieldDecoration(hint, {Widget? icon}) {
  return InputDecoration(
    border: InputBorder.none,
    hintText: hint,
    suffixIcon: icon ?? null,
    filled: true,
    fillColor: Colors.grey.withOpacity(0.4),
    focusedBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: primaryColor),
      borderRadius: BorderRadius.circular(10.0),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    ),
  );
}

comingSoon(context) {
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Column(
              children: [
                Center(child: Text('Coming Soon')),
                box20,
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ),
          ));
}

displaySnackBar(text, ctx, [time = 2]) {
  ScaffoldMessenger.of(ctx).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: time),
    ),
  );
}

themeData(context) {
  return ThemeData(
    appBarTheme:
        Theme.of(context).appBarTheme.copyWith(brightness: Brightness.light),
    textTheme: GoogleFonts.montserratTextTheme(
      Theme.of(context).textTheme,
    ),
    selectedRowColor: primaryColor,
    primaryColor: primaryColor,
    accentColor: primaryColor,
    backgroundColor: primaryColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: primaryColor, // background
        onPrimary: Colors.white, // foreground
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
    ),
  );
}

const EdgeInsets padding10 = EdgeInsets.all(10);
const SizedBox wbox5 = SizedBox(
  width: 5,
);
const SizedBox wbox10 = SizedBox(
  width: 10,
);
const SizedBox wbox20 = SizedBox(
  width: 20,
);
const SizedBox wbox30 = SizedBox(
  width: 30,
);
const SizedBox box5 = SizedBox(
  height: 5,
);
const SizedBox box10 = SizedBox(
  height: 10,
);
const SizedBox box20 = SizedBox(
  height: 20,
);
const SizedBox box30 = SizedBox(
  height: 30,
);

const primaryColor = Color(0xFFce4d83);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF0c0c10);

InputDecoration dropdownDecoration = InputDecoration(
  fillColor: Colors.white,
  isDense: true,
  counterText: "",
  contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 1),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    borderSide: BorderSide(
      width: 1,
      color: primaryColor,
    ),
  ),
  border: new OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      borderSide: new BorderSide(color: Colors.grey)),
);

Map credentials = {
  "Torren Mirror": {"id": "TorrentMir", "pass": "123"},
  "Xtreme": {"id": "xtremer", "pass": "rahul"}
};
Map genre = {
  0: "Misc",
  28: "Action",
  12: "Adventure",
  16: "Animation",
  35: "Comedy",
  80: "Crime",
  99: "Documentary",
  18: "Drama",
  10751: "Family",
  14: "Fantasy",
  36: "History",
  27: "Horror",
  10402: "Music",
  9648: "Mystery",
  10749: "Romance",
  878: "Science Fiction",
  10770: "TV Movie",
  53: "Thriller",
  10752: "War",
  37: "Western"
};
