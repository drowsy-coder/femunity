import 'package:femunity/features/auth/controller/auth_controller.dart';
import 'package:femunity/features/communities/controller/community_controller.dart';
import 'package:femunity/features/home/delegates/search_community_delegate.dart';
import 'package:femunity/features/home/drawer/list_of_communities.dart';
import 'package:femunity/features/home/drawer/profile_drawer.dart';
import 'package:femunity/theme/pallate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/constants.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _page = 0;
  String _title = 'Home';

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
      if (page == 1) {
        _title = 'Add Post';
      } else {
        _title = 'Home';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final currentTheme = ref.watch(themeNotifierProvider);

    // Determine the text color based on the current theme's brightness
    final textColor = currentTheme.brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] // set color for dark mode
            : Color.fromARGB(255, 255, 209, 215),
        title: Text(
          _title,
          style: TextStyle(color: textColor),
        ),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user!.profilePic),
              ),
              onPressed: () => displayEndDrawer(context),
            );
          })
        ],
      ),
      body: Constants.tabWidgets[_page],
      drawer: CommunityListDrawer(),
      endDrawer: const ProfileDrawer(),
      bottomNavigationBar: CupertinoTabBar(
        activeColor: currentTheme.iconTheme.color,
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] // set color for dark mode
            : Color.fromARGB(255, 255, 209, 215),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
        ],
        onTap: onPageChanged,
        currentIndex: _page,
      ),
    );
  }
}
