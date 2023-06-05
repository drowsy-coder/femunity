import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy & Security Policy'),
        backgroundColor:
            Colors.deepPurple, 
      ),
      body: Container(
        decoration: const BoxDecoration(),
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCard(
                'Introduction',
                'Welcome to Femunity, an app designed to empower women around the world. At Femunity, we take your privacy and security seriously. This privacy policy outlines how we collect, use, and protect your personal information.',
                Colors.orange,
              ),
              const SizedBox(height: 20.0),
              _buildCard(
                'Data Collection',
                'We collect your email id, username, and profile picture when you create an account on Femunity. This information is stored securely on Firebase servers provided by Google. We do not share, sell, or disclose your personal information to any third party.',
                Colors.white,
              ),
              const SizedBox(height: 20.0),
              _buildCard(
                'Data Protection',
                'At Femunity, we take the security of your personal information seriously. We use industry-standard security measures to protect your data. All data is protected, and access to our servers is restricted to authorized personnel only.',
                Colors.green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(String title, String content, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              content,
              style: const TextStyle(fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}
