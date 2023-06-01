import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/sign_in_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({Key? key});

  void signInAsGuest(WidgetRef ref, BuildContext context) {
    ref.read(authControllerProvider.notifier).signInAsGuest(context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(
      body: isLoading
          ? const Loader()
          : SafeArea(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Colors.grey[800]!,
                          Colors.grey[400]!,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 100,
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontFamily: 'FutureLight',
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 7.0,
                                color: Colors.black,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText('Unleash your power'),
                              FlickerAnimatedText(
                                  'Connect with your community'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 300,
                        child: Text(
                          'Femunity',
                          style: TextStyle(
                            fontFamily: 'AlBrush',
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 5.0,
                                color: Colors.black,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            // const SizedBox(height: 30),
                            const SignInButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
