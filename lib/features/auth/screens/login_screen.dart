import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/sign_in_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Skip',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15, // Adjust the height to reduce the spacing
                    ),
                    const Text(
                      'Unleash your power',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const Text(
                      'Connect with your community',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        Constants.textPath,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SignInButton(),
                  ],
                ),
                Positioned(
                  bottom: 15,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/gdsc.png',
                    height: 70,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ],
            ),
    );
  }
}
