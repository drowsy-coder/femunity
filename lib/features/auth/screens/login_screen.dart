import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/sign_in_button.dart';

class LoginScreen extends ConsumerWidget {
  // ignore: use_key_in_widget_constructors
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
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.pink,
                          Colors.orange,
                          Colors.yellow,
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
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/images/logo.png',
                        width: 200,
                        height: 100,
                       
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
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: const [
                          SliderCard(
                            image: 'assets/images/commu.png',
                            title: 'Discover new communities',
                            description:
                                'Find communities of like-minded women to connect with and support each other.',
                          ),
                          SliderCard(
                            image: 'assets/images/idea.png',
                            title: 'Share your thoughts and ideas',
                            description:
                                'Post links, text, and image-based posts to start discussions and share your thoughts and ideas with others.',
                          ),
                          SliderCard(
                            image: 'assets/images/mental.png',
                            title: 'Care for physical & mental health',
                            description:
                                'Learn more about physical & mental health.',
                          ),
                          SliderCard(
                            image: 'assets/images/opport.png',
                            title: 'Get opportunities to grow',
                            description:
                                'Explore opportunities for personal and professional growth.',
                          ),
                          SliderCard(
                            image: 'assets/images/digitalsec.png',
                            title: 'Stay Digitally Secure',
                            description:
                                'Learn how to stay safe and secure in the digital world.',
                          ),
                        ],
                      ),
                      const SizedBox(height: 75),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: const [
                            SignInButton(),
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

class SliderCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const SliderCard({
    required this.image,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.white.withOpacity(0.7),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                image,
                height: 110,
                width: 110,
              ),
         
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[900],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
