import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

import '../../settings/settings.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  void navigateToUserProfile(BuildContext context, String uid) {
    Routemaster.of(context).push('/u/$uid');
  }

  void navigateToResourceCentre(BuildContext context) {
    Routemaster.of(context).push('/resource-centre');
  }

  void toggleTheme(WidgetRef ref) {
    ref.read(themeNotifierProvider.notifier).toggleTheme();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[900] // set color for dark mode
                    : Color(0xFFAEC6CF),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // add this line
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.profilePic),
                    radius: 50,
                  ),
                  SizedBox(height: 20),
                  Center(
                    // add this line
                    child: AnimatedTextKit(
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          user.name,
                          textStyle: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          speed: const Duration(milliseconds: 40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: const Text(
                'My Profile',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(
                Icons.person_3_outlined,
                size: 30,
              ),
              onTap: () => navigateToUserProfile(context, user.uid),
            ),
            // ListTile(
            //   title: const Text('Resource Centre'),
            //   leading: const Icon(
            //     Icons.archive_rounded,
            //     color: Color.fromARGB(255, 0, 225, 255),
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => ResourceCentrePage()),
            //     );
            //   },
            // ),
            // ListTile(
            //   title: const Text('Opportunities'),
            //   leading: const Icon(
            //     Icons.currency_rupee_outlined,
            //     color: Colors.green,
            //   ),
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => OpportunitiesScreen()),
            //     );
            //   },
            // ),
            ListTile(
              title: const Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: const Icon(
                Icons.settings,
                color: Color(0xFF1E90FF),
                size: 30,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsPage()),
                );
              },
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const Text(
                  //   'Dark Mode',
                  //   style: TextStyle(
                  //     fontFamily: 'Montserrat',
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Switch.adaptive(
                  //   value: ref.watch(themeNotifierProvider.notifier).mode ==
                  //       ThemeMode.dark,
                  //   onChanged: (val) => toggleTheme(ref),
                  //   activeColor: Color(0xFF1E90FF),
                  // ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Version 1.4.5',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    color: Colors.grey[500],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
