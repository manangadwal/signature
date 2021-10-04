import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  final SharedPreferences prefs;
  const Settings({Key? key, required this.prefs});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
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
                trailing: Switch(
                    activeColor: Colors.red,
                    value: widget.prefs.getBool('localAuth') ?? false,
                    onChanged: (value) {
                      widget.prefs
                          .setBool('localAuth', value)
                          .then((value) => setState(() {}));
                    })),
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
