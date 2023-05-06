import 'package:femunity/features/communities/screens/mindfulness.dart';
import 'package:femunity/features/posts/screens/journal_screen.dart';
import 'package:femunity/features/posts/screens/tracking_screen.dart';
import 'package:flutter/material.dart';

class WellnessScreen extends StatelessWidget {
  const WellnessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PeriodTrackerScreen()),
                );
              },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.pink,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 48,
                            child: const Icon(Icons.track_changes, size: 48),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'M\nE\nN\nS\nT\nR\nU\nA\nL \n\nT\nR\nA\nC\nK\nE\nR',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  
                    onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MindfulnessScreen()),
                );
              
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 48,
                            child: const Icon(Icons.spa, size: 48),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'M\n I\nN\nD\nF\nU\nL\nN\nE\nS\nS',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => JournalScreen()),
                );
              },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    color: Colors.orange,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 48,
                            child: const Icon(Icons.book, size: 48),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'J\nO\nU\nR\nN\nA\nL',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}