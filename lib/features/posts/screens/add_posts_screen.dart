import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class AddPostsScreen extends ConsumerWidget {
  const AddPostsScreen({super.key});

  void navigateToType(BuildContext context, String type) {
    Routemaster.of(context).push('/add-posts/$type');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeNotifierProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () => navigateToType(context, 'Image'),
          child: Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: currentTheme.colorScheme.background,
            elevation: 16,
            child: const SizedBox(
              height: 120,
              child: Icon(Icons.image_outlined, size: 40),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => navigateToType(context, 'Text'),
          child: Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: currentTheme.colorScheme.background,
            elevation: 16,
            child: const SizedBox(
              height: 120,
              child: Icon(Icons.text_fields_outlined, size: 40),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => navigateToType(context, 'Link'),
          child: Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: currentTheme.colorScheme.background,
            elevation: 16,
            child: const SizedBox(
              height: 120,
              child: Icon(Icons.link_outlined, size: 40),
            ),
          ),
        )
      ],
    );
  }
}
