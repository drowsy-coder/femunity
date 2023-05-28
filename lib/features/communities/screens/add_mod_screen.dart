import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/models/community_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddModsScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModsScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModsScreenState();
}

class _AddModsScreenState extends ConsumerState<AddModsScreen> {
  Set<String> uids = {};
  int ctr = 0;

  void addUid(String uid) {
    setState(() {
      uids.add(uid);
    });
  }

  void removeUid(String uid) {
    setState(() {
      uids.remove(uid);
    });
  }

  void saveMods() {
    ref.read(communityControllerProvider.notifier).addMods(
          widget.name,
          uids.toList(),
          context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(widget.name)).when(
            data: (Community community) => ListView.builder(
              itemCount: community.members.length,
              itemBuilder: (BuildContext context, int index) {
                final member = community.members[index];
                final isChecked =
                    uids.contains(member) || community.mods.contains(member);

                return ref.watch(getUserDataProvider(member)).when(
                      data: (userData) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.grey[900]
                                    : const Color(0xFFAEC6CF),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                          child: CheckboxListTile(
                            activeColor: const Color(0xFFc779d0),
                            checkColor: Colors.white,
                            value: isChecked,
                            onChanged: (val) {
                              if (val!) {
                                addUid(member);
                              } else {
                                removeUid(member);
                              }
                            },
                            title: Text(
                              userData.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const Loader(),
                    );
              },
            ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loader(),
          ),
    );
  }
}
