import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/utils.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/features/posts/controller/posts_controller.dart';
import 'package:femunity/models/community_model.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profanity_filter/profanity_filter.dart';

class AddPostsTypeScreen extends ConsumerStatefulWidget {
  final String type;

  const AddPostsTypeScreen({Key? key, required this.type}) : super(key: key);

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
      backgroundColor: currentTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            Text('Add ${widget.type}', style: const TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: sharePost,
            style: const ButtonStyle(
                
                ),
            child: const Text(
              'Share',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: isLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Title',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: 'What should the title be?',
                        hintStyle: currentTheme.textTheme.bodyText2!
                            .copyWith(color: currentTheme.hintColor),
                        filled: true,
                      
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(18),
                      ),
                      maxLength: 30,
                      style: currentTheme.textTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    if (isTypeImage)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Image',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                          const SizedBox(height: 10),
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
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          bannerFile!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : const Center(
                                        child: Icon(
                                          Icons.camera_alt_outlined,
                                          size: 40,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (isTypeText)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Text',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: descriptionController,
                            decoration: InputDecoration(
                              hintText: 'Voice your thoughts!',
                              hintStyle: currentTheme.textTheme.bodyText2!
                                  .copyWith(color: currentTheme.hintColor),
                              filled: true,
                       
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                            maxLines: 5,
                            style: currentTheme.textTheme.bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    if (isTypeLink)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Link',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            controller: linkController,
                            decoration: InputDecoration(
                              hintText: 'Enter link here',
                              hintStyle: currentTheme.textTheme.bodyText2!
                                  .copyWith(color: currentTheme.hintColor),
                              filled: true,
                            
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.all(18),
                            ),
                            maxLines: 2,
                            style: currentTheme.textTheme.bodyText2!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    const SizedBox(height: 20),
                    const Text(
                      'Select Community',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ref.watch(userCommunitiesProvider).when(
                          data: (data) {
                            communities = data;

                            if (data.isEmpty) {
                              return const SizedBox();
                            }
                            return DropdownButton(
                              value: selectedCommunity ?? data[0],
                              onChanged: (value) {
                                setState(() {
                                  selectedCommunity = value as Community?;
                                });
                              },
                              items: data
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(
                                        e.name,
                                        style: currentTheme.textTheme.bodyText2!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                          loading: () => const LinearProgressIndicator(),
                          error: (error, stackTrace) =>
                              ErrorText(error: error.toString()),
                        ),
                  ],
                ),
              ),
            ),
    );
  }
}
