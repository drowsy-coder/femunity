import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/models/community_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddModScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModScreenState();
}

class _AddModScreenState extends ConsumerState<AddModScreen> {
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
    ref
        .read(communityControllerProvider.notifier)
        .addMods(widget.name, uids.toList(), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : Color(0xffFEB2B2),
        title: Text(
          'Add Moderators',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).textTheme.headline6?.color,
              ),
        ),
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(widget.name)).when(
          data: (community) => ListView.builder(
              itemCount: community.members.length,
              itemBuilder: (BuildContext context, int index) {
                final member = community.members[index];
                return ref.watch(getUserDataProvider(member)).when(
                    data: (user) {
                      // here member and user.uid are the same thing in case dosent work change it to member
                      if (community.mods.contains(user.uid) && ctr == 0) {
                        uids.add(user.uid);
                      }
                      ctr++;
                      return CheckboxListTile(
                        value: uids.contains(user.uid),
                        onChanged: (val) {
                          if (val!) {
                            addUid(user.uid);
                          } else {
                            removeUid(user.uid);
                          }
                        },
                        title: Text(user.name),
                      );
                    },
                    error: ((error, stackTrace) =>
                        ErrorText(error: error.toString())),
                    loading: () => (const Loader()));
              }),
          error: ((error, stackTrace) => ErrorText(error: error.toString())),
          loading: () => (const Loader())),
    );
  }
}
