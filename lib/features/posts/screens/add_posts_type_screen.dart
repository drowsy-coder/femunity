import 'dart:io';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:femunity/core/utils.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/features/posts/controller/posts_controller.dart';
import 'package:femunity/models/community_model.dart';
import 'package:femunity/theme/pallate.dart';
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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final linkController = TextEditingController();
  File? bannerFile;
  List<Community> communities = [];
  Community? selectedCommunity;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    linkController.dispose();
  }

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void sharePost() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final link = linkController.text.trim();

    // Check for profanity in title, description, and link
    final hasProfanity = ProfanityFilter().hasProfanity(title) ||
        ProfanityFilter().hasProfanity(description) ||
        ProfanityFilter().hasProfanity(link);

    if (widget.type == 'Image' &&
        bannerFile != null &&
        title.isNotEmpty &&
        !hasProfanity) {
      ref.read(postControllerProvider.notifier).shareImagePost(
          context: context,
          title: title,
          selectedCommunity: selectedCommunity ?? communities[0],
          file: bannerFile);
    } else if (widget.type == 'Text' && title.isNotEmpty && !hasProfanity) {
      ref.read(postControllerProvider.notifier).shareTextPost(
            context: context,
            title: title,
            selectedCommunity: selectedCommunity ?? communities[0],
            description: description,
          );
    } else if (widget.type == 'Link' &&
        link.isNotEmpty &&
        title.isNotEmpty &&
        !hasProfanity) {
      ref.read(postControllerProvider.notifier).shareLinkPost(
            context: context,
            title: title,
            selectedCommunity: selectedCommunity ?? communities[0],
            link: link,
          );
    } else {
      showSnackBar(
        context,
        'Please input all the fields or remove any profanity.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = ref.watch(themeNotifierProvider);
    final isTypeImage = widget.type == 'Image';
    final isTypeText = widget.type == 'Text';
    final isTypeLink = widget.type == 'Link';
    final isLoading = ref.watch(postControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${widget.type}'),
        actions: [
          TextButton(
            onPressed: sharePost,
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xFFFEB2B2)),
            ),
            child: Text(
              'Share',
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xffFEB2B2)
                      : Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'What should the title be?',
                      filled: true,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(18),
                    ),
                    maxLength: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (isTypeImage)
                    GestureDetector(
                      onTap: selectBannerImage,
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        color: currentTheme.textTheme.bodyText2!.color!,
                        child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: bannerFile != null
                                ? Image.file(bannerFile!)
                                : const Center(
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 40,
                                    ),
                                  )),
                      ),
                    ),
                  if (isTypeText)
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Voice your thoughts!',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      maxLines: 5,
                    ),
                  if (isTypeLink)
                    TextField(
                      controller: linkController,
                      decoration: const InputDecoration(
                        hintText: 'Enter link here',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(18),
                      ),
                      maxLines: 2,
                    ),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Select Community'),
                  ),
                  ref.watch(userCommunitiesProvider).when(
                        data: (data) {
                          communities = data;

                          if (data.isEmpty) {
                            return const SizedBox();
                          }
                          return DropdownButton(
                              value: selectedCommunity ?? data[0],
                              items: data
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e.name)))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedCommunity = val;
                                });
                              });
                        },
                        error: (error, StackTrace) => ErrorText(
                          error: error.toString(),
                        ),
                        loading: () => const Loader(),
                      ),
                ],
              ),
            ),
    );
  }
}
