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
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900] // set color for dark mode
                : Color(0xFFFAC898),
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
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900] // set color for dark mode
                : Color.fromARGB(255, 254, 254, 254),
            elevation: 16,
            child: const SizedBox(
              height: 120,
              child: Icon(
                Icons.text_fields_outlined,
                size: 40,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => navigateToType(context, 'Link'),
          child: Card(
            margin: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[900] // set color for dark mode
                : Color(0xFF77DD77),
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
