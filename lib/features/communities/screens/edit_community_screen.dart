import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/constants/constants.dart';
import 'package:femunity/core/utils.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:io';

class EditCommunityScreen extends ConsumerStatefulWidget {
  final String name;
  const EditCommunityScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditCommunityScreenState();
}

class _EditCommunityScreenState extends ConsumerState<EditCommunityScreen> {
  File? bannerFile;
  File? profileFile;

  void selectBannerImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        bannerFile = File(res.files.first.path!);
      });
    }
  }

  void selectProfileImage() async {
    final res = await pickImage();

    if (res != null) {
      setState(() {
        profileFile = File(res.files.first.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => Scaffold(
            backgroundColor: Pallete.darkModeAppTheme.backgroundColor,
            appBar: AppBar(
              title: const Text('Edit Community'),
              centerTitle: false,
              actions: [
                TextButton(
                  onPressed: () {},
                  child: const Text("Save"),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: selectBannerImage,
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            strokeCap: StrokeCap.round,
                            color: Pallete
                                .darkModeAppTheme.textTheme.bodyText2!.color!,
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: bannerFile != null
                                  ? Image.file(bannerFile!)
                                  : community.banner.isEmpty ||
                                          community.banner ==
                                              Constants.bannerDefault
                                      ? const Center(
                                          child: Icon(
                                            Icons.camera_alt_outlined,
                                            size: 40,
                                          ),
                                        )
                                      : Image.network(community.banner),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 100,
                          top: 100,
                          left: 10,
                          child: GestureDetector(
                            onTap: selectProfileImage,
                            child: profileFile != null
                                ? CircleAvatar(
                                    backgroundImage: FileImage(profileFile!),
                                    radius: 32,
                                  )
                                : CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(community.avatar),
                                    radius: 32,
                                  ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => ErrorText(error: error.toString()),
          loading: () => const Loader(),
        );
  }
}
