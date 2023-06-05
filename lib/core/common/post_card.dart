import 'package:any_link_preview/any_link_preview.dart';
import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/features/posts/controller/posts_controller.dart';
import 'package:femunity/models/post_model.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({Key? key, required this.post}) : super(key: key);

  void deletePost(WidgetRef ref, BuildContext context) async {
    ref.read(postControllerProvider.notifier).deletePost(post, context);
  }

  void upvotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).upvote(post);
  }

  void downvotePost(WidgetRef ref) async {
    ref.read(postControllerProvider.notifier).downvote(post);
  }

  void navigateToUser(BuildContext context) {
    Routemaster.of(context).push('/u/${post.uid}');
  }

  void navigateToCommunity(BuildContext context) {
    Routemaster.of(context).push(post.communityName);
  }

  void navigateToComments(BuildContext context) {
    Routemaster.of(context).push('/post/${post.id}/comments');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isTypeImage = post.type == 'Image';
    final isTypeText = post.type == 'Text';
    final isTypeLink = post.type == 'Link';
    final currentTheme = ref.watch(themeNotifierProvider);
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.grey[900]!,
                  Colors.blueGrey[900]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () => navigateToCommunity(context),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(post.communityProfilePic),
                    ),
                  ),
                  title: Text(
                    post.communityName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    post.username,
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: post.uid == user.uid
                      ? isGuest
                          ? null
                          : IconButton(
                              onPressed: () => deletePost(ref, context),
                              icon: Icon(
                                Icons.delete,
                                color: Pallete.redColor,
                              ),
                            )
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  
                      Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (isTypeImage)
                        SizedBox(
                          height: 240,
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              post.link!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (isTypeLink)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: AnyLinkPreview(
                            displayDirection: UIDirection.uiDirectionHorizontal,
                            link: post.link!,
                          ),
                        ),
                      if (isTypeText)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            post.description!,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut,
                                transform: Matrix4.translationValues(
                                  0.0,
                                  post.upvotes.contains(user.uid) ? -7.0 : 0.0,
                                  0.0,
                                ),
                                child: IconButton(
                                  onPressed: () => upvotePost(ref),
                                  icon: Icon(
                                    post.upvotes.contains(user.uid)
                                        ? Icons.thumb_up
                                        : Icons.thumb_up_outlined,
                                    size: 26,
                                    color: post.upvotes.contains(user.uid)
                                        ? Colors.green[400]
                                        : null,
                                  ),
                                ),
                              ),
                              Text(
                                '${post.upvotes.length - post.downvotes.length == 0 ? 'Vote' : post.upvotes.length - post.downvotes.length}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height:
                                    post.downvotes.contains(user.uid) ? 38 : 45,
                                child: IconButton(
                                  onPressed: () => downvotePost(ref),
                                  icon: Icon(
                                    post.downvotes.contains(user.uid)
                                        ? Icons.thumb_down
                                        : Icons.thumb_down_outlined,
                                    size: 26,
                                    color: post.downvotes.contains(user.uid)
                                        ? Colors.red[900]
                                        : null,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () => navigateToComments(context),
                                icon: const Icon(Icons.insert_comment),
                                color: Colors.blue,
                              ),
                              Text(
                                '${post.commentCount == 0 ? 'Comment' : post.commentCount}',
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                          ref
                              .watch(
                                getCommunityByNameProvider(post.communityName),
                              )
                              .when(
                                data: (data) {
                                  if (data.mods.contains(user.uid)) {
                                    return IconButton(
                                      onPressed: () => deletePost(ref, context),
                                      icon: Icon(
                                        Icons.admin_panel_settings_sharp,
                                        color: Colors.red[900],
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                },
                                error: (error, stackTrace) =>
                                    ErrorText(error: error.toString()),
                                loading: () => const Loader(),
                              ),
                        ],
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
