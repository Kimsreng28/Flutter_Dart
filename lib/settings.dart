import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
        ),
      ),
      body: Column(
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
          ),
          const ListTile(
            title: Text(
              'Your Name',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w800),
            ),
            subtitle: Text(""),
          ),
          const Card(
            child: ListTile(
              title: Text("Delete account"),
              trailing: Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
          ),
          const Card(
            child: ListTile(
              title: Text("Change Password"),
              trailing: Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
          ),
          TextButton(onPressed: () {}, child: const Text("Logout")),
        ],
      ),
    );
  }
}
