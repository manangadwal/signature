import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favicon/favicon.dart' as favicon;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/meta/Utility/constants.dart';
import 'package:signature/screens/generate.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final passController = TextEditingController();
  final usernameController = TextEditingController();

  Stream<QuerySnapshot<Map<String, dynamic>>> ownerData() {
    return FirebaseFirestore.instance
        .collection("accounts")
        .doc(auth.currentUser!.uid)
        .collection("passwords")
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: ownerData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Text("Error, try again ltaer");
            }
            if (snapshot.hasData) {
              return snapshot.data!.docs.isEmpty
                  ? const Center(child: Text("No Saved Passwords"))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var passData = snapshot.data!.docs[index].data() as Map;
                        return ListTile(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Delete"),
                                    content: const Text(
                                        "Are you sure you want to delete this password?"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text("Cancel"),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      ElevatedButton(
                                        child: Text("Delete"),
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("accounts")
                                              .doc(auth.currentUser!.uid)
                                              .collection("passwords")
                                              .doc(
                                                  snapshot.data!.docs[index].id)
                                              .delete();
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          leading: CircleAvatar(
                              backgroundImage: NetworkImage(passData["icon"])),
                          trailing: IconButton(
                            onPressed: () async {
                              Clipboard.setData(
                                      ClipboardData(text: passData["password"]))
                                  .then((value) {
                                Get.showSnackbar(
                                  GetBar(
                                    icon: Icon(Icons.done),
                                    message: "Password copied successfully",
                                    duration: const Duration(seconds: 2),
                                    isDismissible: true,
                                  ),
                                );
                              });
                            },
                            icon: Icon(Icons.copy),
                          ),
                          title: Text(passData["name"] ?? ""),
                          subtitle: Text(passData["username"] ?? ""),
                        );
                      });
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(25.0))),
              builder: (context) {
                return StatefulBuilder(builder: (BuildContext context,
                    StateSetter setState /*You can rename this!*/) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          box5,
                          Container(
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            height: 5,
                            width: context.width / 4,
                          ),
                          box30,
                          TextFormField(
                              controller: nameController,
                              decoration: textfieldDecoration(
                                "Enter Website Name",
                              )),
                          box20,
                          TextFormField(
                              controller: urlController,
                              onTap: () {
                                if (urlController.text.isEmpty) {
                                  setState(() {
                                    urlController.text = "https://www.";
                                  });
                                }
                              },
                              onChanged: (e) {
                                getUrl(e);
                              },
                              decoration: textfieldDecoration(
                                  "Website URL : https://www...",
                                  icon: icon == null
                                      ? null
                                      : SizedBox(
                                          height: 25,
                                          width: 25,
                                          child: Image.network(icon!),
                                        ))),
                          box20,
                          TextFormField(
                              controller: usernameController,
                              decoration: textfieldDecoration(
                                "Enter Username",
                              )),
                          box20,
                          TextFormField(
                              controller: passController,
                              decoration: textfieldDecoration("Enter Password",
                                  icon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          passController.text = generatepass();
                                        });
                                      },
                                      icon: Icon(Icons.vpn_key)))),
                          box30,
                          box30,
                          GestureDetector(
                            onTap: () {
                              if (!Uri.parse(urlController.text).isAbsolute) {
                                Get.showSnackbar(
                                  GetBar(
                                    icon: Icon(Icons.error),
                                    message: "Please enter a valid Url",
                                    duration: const Duration(seconds: 2),
                                    isDismissible: true,
                                  ),
                                );
                                return;
                              }
                              if (nameController.text.isNotEmpty &&
                                  urlController.text.isNotEmpty &&
                                  usernameController.text.isNotEmpty &&
                                  passController.text.isNotEmpty) {
                                Navigator.pop(context);
                                savePassword(
                                    nameController.text,
                                    urlController.text,
                                    usernameController.text,
                                    passController.text);
                              } else {
                                Get.showSnackbar(
                                  GetBar(
                                    icon: Icon(Icons.error),
                                    message: "All Details are Mandatory",
                                    duration: const Duration(seconds: 2),
                                    isDismissible: true,
                                  ),
                                );
                              }
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                    color: primaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Center(
                                    child: Text("Save",
                                        style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                )),
                          ),
                          box20,
                        ])),
                  );
                });
              });
        },
        child: Icon(
          Icons.add,
          color: primaryColor,
        ),
        backgroundColor: primaryColor.withOpacity(0.2),
        splashColor: Colors.red,
      ),
    );
  }

  getUrl(String url) async {
    try {
      if (Uri.parse(url).isAbsolute) {
        var iconUrl = await favicon.Favicon.getBest(url);
        if (iconUrl != null) {
          setState(() {
            icon = iconUrl.url;
          });
        }
      }
    } catch (e) {}
  }

  String? icon;

  savePassword(String name, String url, String username, String pass) async {
    var db = FirebaseFirestore.instance
        .collection("accounts")
        .doc(auth.currentUser!.uid)
        .collection("passwords");

    Map<String, dynamic> data = {
      "name": name,
      "url": url,
      "username": username,
      "password": pass,
      "icon": icon,
      "timeStamp": FieldValue.serverTimestamp()
    };

    await db.doc(name + username + pass).set(data).then((value) {
      Get.showSnackbar(
        GetBar(
          icon: Icon(Icons.done),
          message: "Password Saved Successfully",
          duration: const Duration(seconds: 2),
          isDismissible: true,
        ),
      );
      passController.clear();
      nameController.clear();
      urlController.clear();
      usernameController.clear();
      icon = null;
    });
  }
}
