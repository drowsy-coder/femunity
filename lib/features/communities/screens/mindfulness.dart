import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:femunity/features/mindfulness/breathing_screen.dart';
import 'package:femunity/features/mindfulness/gratitude_screen.dart';
import 'package:femunity/features/mindfulness/yoga_screen.dart';
import 'package:femunity/features/mindfulness/study_screen.dart';
import 'package:femunity/features/mindfulness/meditation_screen.dart';

class MindfulnessScreen extends StatelessWidget {
  final List<Map<String, dynamic>> _meditationOptions = [
    {
      'title': 'Yoga',
      'icon': Icons.accessibility_new_outlined,
      'color': Colors.pink,
      'screen': YogaScreen(),
    },
    {
      'title': 'Breathing',
      'icon': Icons.air_outlined,
      'color': Colors.green,
      'screen': BreathingExerciseScreen(),
    },
    {
      'title': 'Study',
      'icon': Icons.book_outlined,
      'color': Colors.blue,
      'screen': StudyTimerScreen(),
    },
    {
      'title': 'Gratitude',
      'icon': Icons.favorite_outline,
      'color': Colors.redAccent,
      'screen': GratitudeScreen(),
    },
    {
      'title': 'Meditation',
      'icon': Icons.self_improvement_outlined,
      'color': Colors.deepPurple,
      'screen': MeditationScreen(),
    },
  ];

  final List<Map<String, String>> _links = [
    {'title': 'Mindful.org', 'url': 'https://www.mindful.org/'},
    {'title': 'Headspace', 'url': 'https://www.headspace.com/'},
    {'title': 'Calm', 'url': 'https://www.calm.com/'},
    {'title': 'Insight Timer', 'url': 'https://insighttimer.com/'},
    {'title': 'Ten Percent Happier', 'url': 'https://www.tenpercent.com/'},
    {'title': 'The Tapping Solution', 'url': 'https://www.thetappingsolution.com/'},
  ];

  _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

  void _navigateToScreen(BuildContext context, Map<String, dynamic> option) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => option['screen'],
      ),
    );
  }

  Widget _buildMeditationCard(BuildContext context, Map<String, dynamic> option) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 16.0),
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            colors: [
              option['color'].withOpacity(0.9),
              option['color'],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                option['icon'],
                color: Colors.white,
                size: 36.0,
              ),
              SizedBox(height: 8.0),
              Text(
                option['title'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // Handle meditation card click
        _navigateToScreen(context, option);
      },
    );
  }

  Widget _buildLinkCard(String title, String url) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        height: 80.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.purple,
                size: 24.0,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        // Handle link card click
        _launchURL(url);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mindfulness Screen'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purple.withOpacity(0.9),
              Colors.purple,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Meditation Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              height: 160.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _meditationOptions.length,
                itemBuilder: (BuildContext context, int index) {
                  return Hero(
                    tag: _meditationOptions[index]['title'],
                    child: _buildMeditationCard(context, _meditationOptions[index]),
                  );
                },
              ),
            ),
            SizedBox(height: 24.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Mindfulness Links',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                  color: Colors.black,
                ),
                child: ListView.builder(
                  itemCount: _links.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildLinkCard(
                        _links[index]['title']!, _links[index]['url']!);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}