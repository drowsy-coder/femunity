import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

class WellnessScreen extends StatelessWidget {
  const WellnessScreen({Key? key}) : super(key: key);

  void navigateToSafety(BuildContext context) {
    Routemaster.of(context).push('/safety');
  }

  void navigateToMenstrualTracker(BuildContext context) {
    Routemaster.of(context).push('/menstrual-tracker');
  }

  void navigateToSakhi(BuildContext context) {
    Routemaster.of(context).push('/sakhi-chat');
  }

  void navigateToOpportunities(BuildContext context) {
    Routemaster.of(context).push('/opportunities');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Text(
                'Wellness',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(24),
                mainAxisSpacing: 32,
                crossAxisSpacing: 32,
                children: [
                  GestureDetector(
                    onTap: () {
                    
                      navigateToMenstrualTracker(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 48,
                            child: Icon(Icons.track_changes,
                                size: 48, color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Menstrual Tracker',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                     
                      navigateToSakhi(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 48,
                            child:
                                Icon(Icons.mic, size: 48, color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Sakhi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                      navigateToOpportunities(context);
                      
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 48,
                            child: Icon(Icons.assignment_ind_sharp,
                                size: 48, color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Opportunities',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      
                      navigateToSafety(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 48,
                            child: Icon(Icons.security,
                                size: 48, color: Colors.white),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Safety',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
