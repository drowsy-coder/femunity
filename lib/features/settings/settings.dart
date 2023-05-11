import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:femunity/features/mindfulness/opportunities_screen.dart';
import 'package:femunity/features/posts/screens/resource_centre_screen.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/posts/screens/tracking_screen.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/sign_in_button.dart';
import '../auth/screens/login_screen.dart';

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
              // Handle privacy & security action
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
              // Handle help & support action
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