import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:delayed_display/delayed_display.dart';

class CommunityListDrawer extends ConsumerWidget {
  const CommunityListDrawer({Key? key}) : super(key: key);

  void navigateToCreateCommunity(BuildContext context) {
    Routemaster.of(context).push('/create-community');
  }

  void navigateToCommunity(BuildContext context, Community community) {
    Routemaster.of(context).push(community.name);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900] // set color for dark mode
          : Color.fromARGB(255, 255, 209, 215),
      child: SafeArea(
        child: Column(
          children: [
            ListTile(
              title: const Text('Create a Community'),
              leading: const Icon(Icons.add),
              onTap: () => navigateToCreateCommunity(context),
            ),
            ref.watch(userCommunitiesProvider).when(
                  data: (communities) => Expanded(
                    child: ListView.separated(
                      itemCount: communities.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(),
                      itemBuilder: (BuildContext context, int index) {
                        final community = communities[index];
                        return DelayedDisplay(
                          delay: Duration(milliseconds: 10 * index),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(community.avatar),
                            ),
                            title: Text(community.name),
                            onTap: () {
                              navigateToCommunity(context, community);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  error: (error, stackTrace) =>
                      ErrorText(error: error.toString()),
                  loading: () => const Loader(),
                )
          ],
        ),
      ),
    );
  }
}
