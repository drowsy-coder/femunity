import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

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
        backgroundColor:
            Colors.deepPurple, // Radically changing the app bar color
      ),
      body: Container(
        decoration: const BoxDecoration(),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            _buildButtonCard(
              Icons.security,
              'Privacy & Security',
              () => navigateToPrivacy(context),
            ),
            _buildButtonCard(
              Icons.help,
              'Help & Support',
              () => navigateToSupport(context),
            ),
            const SizedBox(height: 16.0),
            _buildButtonCard(
              Icons.logout_outlined,
              'Log Me Out',
              () {
                logOut(ref);
                Navigator.pop(context);
              },
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonCard(IconData icon, String title, VoidCallback onPressed,
      {Color color = Colors.deepPurple}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: color,
              ),
              const SizedBox(width: 16.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const ProviderScope(
    child: MaterialApp(
      home: SettingsPage(),
    ),
  ));
}
