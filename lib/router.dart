import 'package:femunity/features/auth/screens/login_screen.dart';
import 'package:femunity/features/communities/screens/community_screen.dart';
import 'package:femunity/features/communities/screens/create_community_sc.dart';
import 'package:femunity/features/communities/screens/edit_community_screen.dart';
import 'package:femunity/features/communities/screens/mod_tools_screen.dart';
import 'package:femunity/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/:name': (RouteData routeData) => MaterialPage(
        child: CommunityScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/mod-tools/:name': (routeData) => MaterialPage(
        child: ModToolsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/edit-community/:name': (routeData) => MaterialPage(
        child: EditCommunityScreen(
          name: routeData.pathParameters['name']!,
        ),
      )
});
