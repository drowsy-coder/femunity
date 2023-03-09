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
        title: Text('Period Tracker History'),
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

                return ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text(
                      '${DateFormat.yMMMMd().format(periodStartDate)} - ${DateFormat.yMMMMd().format(periodEndDate)}'),
                  subtitle: Text(
                      'Cycle length: $cycleLength days, Period length: $periodLength days'),
                  trailing: Text(periodOn ? 'On' : 'Off'),
                  onTap: () {
                    // do something on tap
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
