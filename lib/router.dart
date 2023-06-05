import 'package:femunity/features/auth/screens/login_screen.dart';
import 'package:femunity/features/communities/screens/add_mod_screen.dart';
import 'package:femunity/features/communities/screens/community_screen.dart';
import 'package:femunity/features/communities/screens/create_community_sc.dart';
import 'package:femunity/features/communities/screens/edit_community_screen.dart';
import 'package:femunity/features/communities/screens/mod_tools_screen.dart';
import 'package:femunity/features/home/home_screen.dart';
import 'package:femunity/features/resource_center/opportunities_screen.dart';
import 'package:femunity/features/resource_center/Digital%20Safety/digital_safety.dart';
import 'package:femunity/features/resource_center/Digital%20Safety/safe_screen1.dart';
import 'package:femunity/features/resource_center/Digital%20Safety/safe_screen2.dart';
import 'package:femunity/features/resource_center/Menstrual%20Tips%20Screen/exercise_tips.dart';
import 'package:femunity/features/resource_center/Menstrual%20Tips%20Screen/food_tips.dart';
import 'package:femunity/features/resource_center/Menstrual%20Tips%20Screen/stress_tips.dart';
import 'package:femunity/features/posts/screens/add_posts_type_screen.dart';
import 'package:femunity/features/resource_center/Sakhi/chat_screen.dart';
import 'package:femunity/features/posts/screens/comment_screen.dart';
import 'package:femunity/features/resource_center/Menstrual%20Tips%20Screen/history_screen.dart';
import 'package:femunity/features/posts/screens/resource_centre_screen.dart';
import 'package:femunity/features/resource_center/Menstrual%20Tips%20Screen/tracking_screen.dart';
import 'package:femunity/features/settings/help.dart';
import 'package:femunity/features/settings/privacy.dart';
import 'package:femunity/features/settings/settings.dart';
import 'package:femunity/features/user_profile/screens/edit_profie_screen.dart';
import 'package:femunity/features/user_profile/screens/user_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/create-community': (_) =>
      const MaterialPage(child: CreateCommunityScreen()),
  '/menstrual-tracker': (_) => const MaterialPage(child: PeriodTrackerScreen()),
  '/sakhi-chat': (_) => const MaterialPage(child: ChatScreen()),
  '/opportunities': (_) => const MaterialPage(child: OpportunitiesScreen()),
  '/safety': (_) => MaterialPage(child: ResourceCentrePage()),
  '/period-history': (_) => const MaterialPage(child: HistoryScreen()),
  '/health-tips': (_) => const MaterialPage(child: HealthTipsScreen()),
  '/eating': (_) => const MaterialPage(child: FoodTipsScreen()),
  '/exercise': (_) => const MaterialPage(child: ExerciseTipsScreen()),
  '/stress': (_) => const MaterialPage(child: StressTipsScreen()),
  '/safety/digital': (_) => const MaterialPage(child: FemaleDigitalSafetyScreen()),
  '/safety/digital/cyber': (_) => const MaterialPage(child: CyberCrimeGuideScreen()),
  '/safety/digital/sexual': (_) =>
      const MaterialPage(child: SexualHarassmentScreen()),
  '/settings': (_) => const MaterialPage(child: SettingsPage()),
  '/help-support': (_) => const MaterialPage(child: HelpAndSupportScreen()),
  '/privacy-policy': (_) => const MaterialPage(child: PrivacyPolicyScreen()),
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
      ),
  '/add-mods/:name': (routeData) => MaterialPage(
        child: AddModsScreen(
          name: routeData.pathParameters['name']!,
        ),
      ),
  '/u/:uid': (routeData) => MaterialPage(
        child: UserProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/edit-profile/:uid': (routeData) => MaterialPage(
        child: EditProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/add-posts/:type': (routeData) => MaterialPage(
        child: AddPostsTypeScreen(
          type: routeData.pathParameters['type']!,
        ),
      ),
  '/post/:postId/comments': (route) => MaterialPage(
        child: CommentsScreen(
          postId: route.pathParameters['postId']!,
        ),
      ),
  '/resource-centre': (_) => MaterialPage(child: ResourceCentrePage()),
});
