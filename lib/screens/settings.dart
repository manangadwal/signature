import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/meta/Utility/constants.dart';

class Settings extends StatefulWidget {
  const Settings({
    Key? key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }

  Future<SharedPreferences> checkLock() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Column(
          children: [
            ListTile(
              title: Text("Fingerprint Lock"),
              trailing: FutureBuilder(
                  future: checkLock(),
                  builder: (context, snapshot) {
                    return Switch(
                        activeColor: primaryColor,
                        value: snapshot.hasData
                            ? prefs.getBool('localAuth') ?? false
                            : false,
                        onChanged: (value) {
                          prefs
                              .setBool('localAuth', value)
                              .then((value) => setState(() {}));
                        });
                  }),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                Navigator.pushNamed(context, '/settings');
              },
            ),
            ListTile(
              title: Text('About'),
              onTap: () {
                Navigator.pushNamed(context, '/about');
              },
            ),
          ],
        ));
  }
}
