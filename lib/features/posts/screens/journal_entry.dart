import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JournalEntryScreen extends StatefulWidget {
  final String? existingTitle;
  final String? existingBody;
  final DateTime? existingTimestamp;
  final String? documentId;

  JournalEntryScreen({
    this.existingTitle,
    this.existingBody,
    this.existingTimestamp,
    this.documentId,
  });

  @override
  _JournalEntryScreenState createState() => _JournalEntryScreenState();
}

class _JournalEntryScreenState extends State<JournalEntryScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late CollectionReference<Map<String, dynamic>> _journalEntriesRef;

  @override
  void initState() {
    super.initState();
    _journalEntriesRef = FirebaseFirestore.instance.collection('journal_entries');
    if (widget.existingTitle != null && widget.existingBody != null) {
      _titleController.text = widget.existingTitle!;
      _bodyController.text = widget.existingBody!;
    }
  }

  Future<void> _saveJournalEntry() async {
    final user = _auth.currentUser!;
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      return;
    }

    final data = {
      'userId': user.uid,
      'title': title,
      'body': body,
      'timestamp': Timestamp.now(),
    };

    if (widget.documentId != null) {
      await _journalEntriesRef.doc(widget.documentId).update(data);
    } else {
      await _journalEntriesRef.add(data);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Journal Entry',
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
              size: 28.0,
            ),
            onPressed: _saveJournalEntry,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey.shade700,
                ),
              ),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: TextFormField(
                controller: _bodyController,
                decoration: InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey.shade700,
                  ),
                ),
                maxLines: null,
                expands: true,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
