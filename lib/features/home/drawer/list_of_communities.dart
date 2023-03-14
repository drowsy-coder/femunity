import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/core/common/sign_in_button.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
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
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    return Drawer(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[900] // set color for dark mode
          : Color(0xFFffe9ec),
      child: SafeArea(
        child: Column(
          children: [
            isGuest
                ? const SignInButton()
                : ListTile(
                    title: Text(
                      'Create a Community',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    leading: Icon(
                      Icons.add_box,
                      color: Colors.white,
                      size: 30,
                    ),
                    onTap: () => navigateToCreateCommunity(context),
                  ),
            if (!isGuest)
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
