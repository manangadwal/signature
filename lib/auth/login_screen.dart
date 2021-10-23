import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:signature/meta/Utility/Constants.dart';
import 'package:signature/screens/bottom_navbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: context.height,
          width: context.width,
          child: Column(children: [
            Spacer(),
            Image.asset(
              "assets/logo.png",
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            Text.rich(
              TextSpan(
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold, fontSize: 40),
                children: [
                  TextSpan(
                    text: 'GET',
                  ),
                  TextSpan(
                    text: 'PASS',
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, color: primaryColor),
                  ),
                ],
              ),
            ),
            box10,
            Text(
              "Never forget a password anymore",
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500, fontSize: 17),
            ),
            Spacer(
              flex: 5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GestureDetector(
                onTap: () {
                  googleLogin();
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.all(
                            Radius.circular(isLoading ? 60 : 5))),
                    child: isLoading
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white)),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(13),
                            child: Center(
                              child: Text("Get Started",
                                  style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600)),
                            ),
                          )),
              ),
            ),
            Spacer(),
          ]),
        ));
  }

  Future googleLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      final user = await googleSignIn.signIn();
      if (user == null) {
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        final googleAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await auth.signInWithCredential(credential).then((value) async {
          debugPrint("User is New = ${value.additionalUserInfo!.isNewUser}");

          await createUser(value.user!);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      debugPrint(e.toString());
      Get.snackbar("Error", "Error, please try again later..!!");
    }
  }

  Future createUser(User user) async {
    var db = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    if (db.exists) {
    } else {
      Map<String, dynamic> data = {
        "name": user.displayName,
        "email": user.email,
        "photoUrl": user.photoURL,
      };

      await firebaseFirestore.collection("accounts").doc(user.uid).set(data);
    }
    Get.offAll(() => const BottomNavBar());
  }
}
