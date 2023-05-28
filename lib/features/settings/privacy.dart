import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security Policy'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Introduction',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Welcome to Femunity, an app designed to empower women around the world. At Femunity, we take your privacy and security seriously. This privacy policy outlines how we collect, use, and protect your personal information.',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Data Collection',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'We collect your email id, username, and profile picture when you create an account on Femunity. This information is stored securely on Firebase servers provided by Google. We do not share, sell or disclose your personal information to any third party.',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Data Protection',
              style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'At Femunity, we take the security of your personal information seriously. We use industry-standard security measures to protect your data. All data is protected, and access to our servers is restricted to authorized personnel only.',
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
