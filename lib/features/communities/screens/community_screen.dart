import 'package:femunity/core/common/error_text.dart';
import 'package:femunity/core/common/loader.dart';
import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/models/community_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class CommunityScreen extends ConsumerWidget {
  final String name;
  const CommunityScreen({super.key, required this.name});

  void navigateToModTools(BuildContext context) {
    Routemaster.of(context).push('/mod-tools/$name');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
        body: ref.watch(getCommunityByNameProvider(name)).when(
            data: (community) => NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 150,
                        floating: true,
                        snap: true,
                        flexibleSpace: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                community.banner,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              Align(
                                alignment: Alignment.topLeft,
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(community.avatar),
                                  radius: 35,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    community.name,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  community.mods.contains(user.uid)
                                      ? OutlinedButton(
                                          onPressed: () {
                                            navigateToModTools(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              foregroundColor:
                                                  const Color(0xffFEB2B2),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(20))),
                                          child: const Text('Mod Tools'),
                                        )
                                      : OutlinedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25),
                                              foregroundColor:
                                                  const Color(0xffFEB2B2),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadiusDirectional
                                                          .circular(20))),
                                          child: Text(community.members
                                                  .contains(user.uid)
                                              ? 'Joined'
                                              : 'Join'),
                                        )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child:
                                    Text('${community.members.length} members'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ];
                  },
                  body: const Text('Displaying Posts'),
                ),
            error: (error, StackTrace) => ErrorText(error: error.toString()),
            loading: () => const Loader()));
  }
}
