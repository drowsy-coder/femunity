import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPostsTypeScreen extends ConsumerStatefulWidget {
  final String type;
  const AddPostsTypeScreen({super.key, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AddPostsTypeScreenState();
}

class _AddPostsTypeScreenState extends ConsumerState<AddPostsTypeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: Text('Share'))],
      ),
    );
  }
}
