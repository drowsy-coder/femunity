import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileDrawer extends ConsumerWidget {
  const ProfileDrawer({Key? key}) : super(key: key);

  void logOut(WidgetRef ref) {
    ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Drawer(
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
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            ListTile(
              title: const Text('My Profile'),
              leading: const Icon(Icons.person_3_outlined),
              onTap: () => {},
            ),
            ListTile(
              title: const Text('Log Me Out'),
              leading: Icon(
                Icons.logout_outlined,
                color: Pallete.redColor,
              ),
              onTap: () => logOut(ref),
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
                  Switch.adaptive(value: true, onChanged: (val) {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
