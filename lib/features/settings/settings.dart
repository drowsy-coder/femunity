import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/settings/help.dart';
import 'package:femunity/features/settings/privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        children: [
          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Edit Profile'),
          //   onTap: () {
          //     // Handle edit profile action
          //   },
          // ),
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.notifications),
          //   title: Text('Notifications'),
          //   onTap: () {
          //     // Handle notifications action
          //   },
          // ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('Privacy & Security'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PrivacyPolicyScreen()));
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.language),
          //   title: Text('Language'),
          //   onTap: () {
          //     // Handle language action
          //   },
          // // ),
          // Divider(),
          ListTile(
            leading: Icon(Icons.help),
            title: Text('Help & Support'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HelpAndSupportScreen()));
            },
          ),
          Divider(),
          ListTile(
            title: const Text('Log Me Out'),
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.orange,
            ),
            onTap: () {
              // Call the logOut function to log out the user
              logOut(ref);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      home: SettingsPage(),
    ),
  ));
}
