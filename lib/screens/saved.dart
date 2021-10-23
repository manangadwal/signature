import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Saved extends StatefulWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final passController = TextEditingController();
  final titleController = TextEditingController();
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
            print(snapshot.data!.docs);
            if (!snapshot.hasData) {
              return const Text("Error, try again ltaer");
            }
            if (snapshot.hasData) {
              return snapshot.data!.docs.isEmpty
                  ? Center(child: Text("No Saved Passwords"))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        var passData = snapshot.data!.docs[index].data() as Map;
                        return ListTile(
                          leading: const Icon(Icons.lock),
                          trailing: IconButton(
                            onPressed: () async {
                              await FirebaseFirestore.instance
                                  .collection("accounts")
                                  .doc(auth.currentUser!.uid)
                                  .collection("passwords")
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();
                            },
                            icon: Icon(Icons.delete),
                          ),
                          title: Text(passData["title"] ?? ""),
                          subtitle: Text(passData["password"] ?? ""),
                        );
                      });
            }
            return Container();
          }),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Center(child: Text('Save Password')),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: titleController,
                          decoration: InputDecoration(label: Text("Title")),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: TextFormField(
                          controller: passController,
                          decoration: InputDecoration(label: Text("Password")),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: IconButton(
                              splashColor: Colors.red,
                              onPressed: () {
                                savePassword(
                                    titleController.text, passController.text);
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.check))),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ));
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        splashColor: Colors.red,
      ),
    );
  }

  savePassword(String title, String pass) async {
    var db = FirebaseFirestore.instance
        .collection("accounts")
        .doc(auth.currentUser!.uid)
        .collection("passwords");

    Map<String, dynamic> data = {
      "title": title,
      "password": pass,
      "timeStamp": FieldValue.serverTimestamp()
    };

    await db.doc(title + pass).set(data).then((value) {
      passController.clear();
      titleController.clear();
    });
  }
}
