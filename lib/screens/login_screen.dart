import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/auth/auth.dart';
import 'package:signature/screens/homepage.dart';

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
        // backgroundColor: Colors.white,
        body: Container(
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Image.asset(
                "assets/s.png",
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 150,
                      height: 45,
                      child: isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateColor.resolveWith((states) =>
                                          states.contains(MaterialState.pressed)
                                              ? Colors.red
                                              : Colors.black)),
                              onPressed: () async {
                                var prefs =
                                    await SharedPreferences.getInstance();
                                bool localAuth =
                                    prefs.getBool("localAuth") ?? false;

                                if (localAuth) {
                                  try {
                                    final isAuthenticated =
                                        await Localauth.authenticate();

                                    if (isAuthenticated) {
                                      googleLogin();
                                    } else {
                                      Get.snackbar("Error",
                                          "Authentication Needed to continue");
                                    }
                                  } catch (e) {
                                    Get.snackbar("Error",
                                        "Authentication Needed to continue");
                                  }
                                } else
                                  googleLogin();
                              },
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
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
    Get.offAll(() => const Home());
  }
}
