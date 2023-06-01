import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SettingsPage extends ConsumerWidget {
  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void navigateToPrivacy(BuildContext context) {
    Routemaster.of(context).push('/privacy-policy');
  }

  void navigateToSupport(BuildContext context) {
    Routemaster.of(context).push('/help-support');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        children: [
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Privacy & Security'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => PrivacyPolicyScreen()));
              navigateToPrivacy(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help & Support'),
            onTap: () {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => HelpAndSupportScreen()));
              navigateToSupport(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Log Me Out'),
            leading: const Icon(
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
