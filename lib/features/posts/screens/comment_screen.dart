import 'package:delayed_display/delayed_display.dart';
import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/common/post_card.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/posts/controller/posts_controller.dart';
import 'package:femunity/features/posts/widget/comment_card.dart';
import 'package:femunity/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profanity_filter/profanity_filter.dart';

class CommentsScreen extends ConsumerStatefulWidget {
  final String postId;
  const CommentsScreen({
    super.key,
    required this.postId,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends ConsumerState<CommentsScreen> {
  final commentController = TextEditingController();
  final filter = ProfanityFilter();

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  void addComment(Post post) {
    String commentText = commentController.text.trim();
    if (filter.hasProfanity(commentText)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Your comment contains inappropriate language!"),
            backgroundColor: Color(0xFFAEC6CF)),
      );
    } else {
      ref.read(postControllerProvider.notifier).addComment(
            context: context,
            text: commentText,
            post: post,
          );
      setState(() {
        commentController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
      
        child: ref.watch(getPostByIdProvider(widget.postId)).when(
              data: (data) {
                return Column(
                  children: [
                    PostCard(post: data),
                    if (!isGuest)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).brightness ==
                                    Brightness.dark
                                ? Colors.grey[900] // set color for dark mode
                                : const Color(0xFFAEC6CF),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: commentController,
                                  decoration: const InputDecoration(
                                    hintText: 'What\'s your take?',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => addComment(data),
                                icon: const Icon(Icons.send),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ref.watch(getPostCommentsProvider(widget.postId)).when(
                          data: (data) {
                            return ListView.separated(
                                 
                                shrinkWrap: true, 
                                physics:
                                    const NeverScrollableScrollPhysics(), 
                                itemCount: data.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(),
                                itemBuilder: (BuildContext context, int index) {
                                  final comment = data[index];
                                  return DelayedDisplay(
                                      delay: Duration(milliseconds: 5 * index),
                                      child: CommentCard(comment: comment));
                                });
                          },
                          error: (error, stackTrace) {
                            return ErrorText(
                              error: error.toString(),
                            );
                          },
                          loading: () => const Loader(),
                        ),
                  ],
                );
              },
              error: (error, stackTrace) => ErrorText(
                error: error.toString(),
              ),
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
