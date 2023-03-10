import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Period Tracker History',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white // set text color for dark mode
                : Colors.black, // set text color for light mode
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] // set color for dark mode
            : Color(0xFFffe9ec),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('period-tracker-data')
            .orderBy('periodStartDate', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<DocumentSnapshot> documents = snapshot.data!.docs;
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
                        : Color(0xFFffe9ec),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16.0),
                      onTap: () {
                        // do something on tap
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
                            SizedBox(height: 8),
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
                            SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
