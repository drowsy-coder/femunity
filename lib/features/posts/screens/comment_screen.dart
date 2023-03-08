import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/common/post_card.dart';
import 'package:femunity/features/posts/controller/posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommentScreen extends ConsumerStatefulWidget {
  final String postId;

  const CommentScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentScreenState();
}

class _CommentScreenState extends ConsumerState<CommentScreen> {
  final commentController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ref.watch(getPostByIdProvider(widget.postId)).when(
              data: (data) {
                return Column(
                  children: [
                    PostCard(post: data),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: "What's your take?",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                          filled: true,
                          fillColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[900] // set color for dark mode
                                  : Color(0xFFffe9ec),
                        ),
                      ),
                    ),
                  ],
                );
              },
              error: (error, StackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
