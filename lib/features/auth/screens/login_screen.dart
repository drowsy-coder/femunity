import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../../core/common/sign_in_button.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 30, 
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontFamily: 'FutureLight',
                            fontSize: 29,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 7.0,
                                color: Colors.white,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              FlickerAnimatedText('Unleash your power'),
                              FlickerAnimatedText('Connect with your community'),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 400.0,
                        child: TextLiquidFill(
                          text: 'Femunity',
                          waveColor: Color(0xFFff48a5),
                          textStyle: TextStyle(
                            fontFamily: 'AlBrush',
                            fontSize: 79.50,
                          ),
                          boxHeight: 150.0,
                        ),
                      ),
                      const SignInButton(),
                    ],
                  ),
                ],
              ),
          ),
    );
  }
}