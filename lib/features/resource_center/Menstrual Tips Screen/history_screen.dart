import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late String userId;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  Future<void> getUserInfo() async {

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Period Tracker History',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white 
                : Colors.black, 
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] 
            : const Color(0xFFAEC6CF),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('period-tracker-data')
            .where('userId', isEqualTo: userId)
            .orderBy('periodStartDate', descending: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          if (documents.isEmpty) {
            return const Center(
              child: Text('No data found'),
            );
          }

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              DateTime periodStartDate =
                  (documents[index].get('periodStartDate') as Timestamp)
                      .toDate();
              DateTime periodEndDate =
                  (documents[index].get('periodEndDate') as Timestamp)
                      .toDate();
              String cycleLength = documents[index].get('cycleLength');
              String periodLength = documents[index].get('periodLength');
              bool periodOn = documents[index].get('periodOn');
              DateTime nextPeriodDate =
                  (documents[index].get('nextPeriodDate') as Timestamp)
                      .toDate();

              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  elevation: 8,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900] // set color for dark mode
                      : const Color(0xFFAEC6CF),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.0),
                    onTap: () {
                
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${DateFormat.yMMMMd().format(periodStartDate)} - ${DateFormat.yMMMMd().format(periodEndDate)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors
                                      .purpleAccent // set text color for dark mode
                                  : Colors
                                      .purpleAccent, // set text color for light mode
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Cycle length: $cycleLength days, Period length: $periodLength days',
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors
                                      .white // set text color for dark mode
                                  : Colors
                                      .black, // set text color for light mode
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}