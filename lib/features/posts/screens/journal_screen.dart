import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:femunity/features/posts/screens/journal_entry.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JournalScreen extends StatefulWidget {
  @override
  _JournalScreenState createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  late CollectionReference<Map<String, dynamic>> _journalEntriesRef;
  late Stream<QuerySnapshot<Map<String, dynamic>>> _journalEntriesStream;

  @override
  void initState() {
    super.initState();
    _journalEntriesRef =
        FirebaseFirestore.instance.collection('journal_entries');
    _journalEntriesStream =
        _journalEntriesRef.orderBy('timestamp', descending: true).snapshots();
  }

  _navigateToJournalEntryScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => JournalEntryScreen(),
      ),
    );
  }

  _formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('MMM d, yyyy - h:mm a');
    return formatter.format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: _navigateToJournalEntryScreen,
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.edit, size: 32.0),
                  const SizedBox(width: 16.0),
                  const Text(
                    "What's on your mind?",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _journalEntriesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                      snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                      child: Text('No journal entries yet. Start writing!'));
                }
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    final String title = document['title'];
                    final String body = document['body'];
                    final DateTime timestamp =
                        document['timestamp'].toDate();
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => JournalEntryScreen(
                              existingTitle: title,
                              existingBody: body,
                              existingTimestamp: timestamp,
                              documentId: document.id,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        margin:
                            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                body,
                                style: const TextStyle(fontSize: 16.0),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                _formatDateTime(timestamp),
                                style: const TextStyle(
                                    fontSize: 14.0, color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}