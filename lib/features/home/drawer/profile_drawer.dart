import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:femunity/features/posts/screens/resource_centre_screen.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900] // set color for dark mode
          : Color(0xFFffe9ec),
      child: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
                radius: 70,
              ),
            ),
            const SizedBox(height: 10),
            AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TypewriterAnimatedText(
                  user.name,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  speed: const Duration(milliseconds: 40),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person_3_outlined),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            ListTile(
              title: const Text('Log Me Out'),
              leading: Icon(
                Icons.logout_outlined,
                color: Pallete.redColor,
              ),
              onTap: () => logOut(ref),
            ),
            ListTile(
              title: const Text('Resource Centre'),
              leading: const Icon(
                Icons.help_center_outlined,
                color: Color.fromARGB(255, 25, 235, 25),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ResourceCentrePage()),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dark Mode',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Switch.adaptive(
                      value: ref.watch(themeNotifierProvider.notifier).mode ==
                          ThemeMode.dark,
                      onChanged: (val) => toggleTheme(ref)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
