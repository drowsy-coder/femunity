import 'package:femunity/features/communities/screens/health_screen.dart';
import 'package:femunity/features/feed/feed_screen.dart';
import 'package:femunity/features/posts/screens/add_posts_screen.dart';
import 'package:flutter/material.dart';

class Constants {
  static const logoPath = 'assets/images/logo.png';
  static const welcomePath = 'assets/images/text.png';
  static const googleLogo = 'assets/images/google.png';

  static const bannerDefault =
      'https://t4.ftcdn.net/jpg/02/96/75/99/360_F_296759927_PwFDH4BwlTdBjEvfWCXJ9zA4qo9JZzfo.jpg';
  static const avatarDefault =
      'https://cdn-icons-png.flaticon.com/512/1391/1391034.png';

  static const tabWidgets = [
    FeedScreen(),
    AddPostsScreen(),
    WellnessScreen(),
  ];

  static const IconData up =
      IconData(0xe800, fontFamily: 'femFont', fontPackage: null);
  static const IconData down =
      IconData(0xe801, fontFamily: 'femFont', fontPackage: null);

  static const awardsPath = 'assets/images/awards';

  static const awards = {
    'awesomeAns': '${Constants.awardsPath}/awesomeanswer.png',
    'gold': '${Constants.awardsPath}/gold.png',
    'platinum': '${Constants.awardsPath}/platinum.png',
    'helpful': '${Constants.awardsPath}/helpful.png',
    'plusone': '${Constants.awardsPath}/plusone.png',
    'rocket': '${Constants.awardsPath}/rocket.png',
    'thankyou': '${Constants.awardsPath}/thankyou.png',
    'til': '${Constants.awardsPath}/til.png',
  };
}
