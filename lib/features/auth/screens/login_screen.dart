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
      appBar: AppBar(
        title: Image.asset(
          Constants.logoPath,
          height: 40,
        ),
        // actions: [
        //   TextButton(
        //     onPressed: () => signInAsGuest(ref, context),
        //     child: Text(
        //       'Skip',
        //       style: TextStyle(
        //           fontSize: 18,
        //           color: Theme.of(context).brightness == Brightness.dark
        //               ? Color(0xffFEB2B2)
        //               : Color.fromARGB(255, 0, 0, 0)),
        //     ),
        //   ),
        // ],
      ),
      body: isLoading
          ? const Loader()
          : Stack(
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
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200.0,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                      ),
                      items: [
                        // 'https://example.com/image1.jpg',
                        // 'https://example.com/image2.jpg',
                        // 'https://example.com/image3.jpg',
                      ].map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Image.network(
                                i,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}