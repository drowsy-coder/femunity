import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _journalEntriesRef =
      FirebaseFirestore.instance.collection('journal_entries');

  Stream<QuerySnapshot<Map<String, dynamic>>> getJournalEntries() {
    return _journalEntriesRef.orderBy('timestamp', descending: true).snapshots();
  }

  Future<void> addJournalEntry(String title, String body) async {
    final Map<String, dynamic> data = {
      'title': title,
      'body': body,
      'timestamp': Timestamp.now(),
    };
    await _journalEntriesRef.add(data);
  }

  Future<void> updateJournalEntry(String documentId, String title, String body) async {
    final Map<String, dynamic> data = {
      'title': title,
      'body': body,
    };
    await _journalEntriesRef.doc(documentId).update(data);
  }

  Future<void> deleteJournalEntry(String documentId) async {
    await _journalEntriesRef.doc(documentId).delete();
  }
}