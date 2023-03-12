import 'package:femunity/features/communities/screens/financial_tips_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FinancialTrackerScreen extends StatefulWidget {
  @override
  _FinancialTrackerScreenState createState() => _FinancialTrackerScreenState();
}

class _FinancialTrackerScreenState extends State<FinancialTrackerScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  User? _loggedInUser;
  String? _note;
  double? _amount;
  double _totalExpenses = 0.0;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getTotalExpenses();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        _loggedInUser = user;
      });
    }
  }

  Future<void> _addExpense() async {
    try {
      final expense = {
        'note': _note,
        'amount': _amount,
        'createdAt': DateTime.now(),
        'userId': _loggedInUser?.uid,
      };
      await _firestore.collection('expenses').add(expense);
      setState(() {
        _note = null;
        _amount = null;
        getTotalExpenses();
      });
    } catch (e) {
      print(e);
    }
  }

  void getTotalExpenses() async {
    final querySnapshot = await _firestore
        .collection('expenses')
        .where('userId', isEqualTo: _loggedInUser?.uid)
        .get();
    final totalExpenses = querySnapshot.docs.fold(0.0, (total, doc) {
      final expense = doc.data()!;
      return total + (expense['amount'] as double);
    });
    setState(() {
      _totalExpenses = totalExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] // set color for dark mode
            : Color(0xFFffe9ec),
        title: Text(
          'Financial Tracking',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FinancialTipsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Note',
              ),
              onChanged: (value) {
                setState(() {
                  _note = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Amount',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.tryParse(value);
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _note == null || _amount == null ? null : _addExpense,
              child: Text('Add Expense'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('expenses')
                    .where('userId', isEqualTo: _loggedInUser?.uid)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final expenses = snapshot.data!.docs;
                  double totalExpenses = 0;
                  for (var expense in expenses) {
                    final amount = expense['amount'] ?? 0;
                    totalExpenses += amount;
                  }
                  return Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Expenses:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '₹${totalExpenses.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 18.0,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? Colors.white
                                    : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Expanded(
                        child: ListView.builder(
                      itemCount: expenses.length,
                      itemBuilder: (context, index) {
                        final expense =
                            expenses[index].data()! as Map<String, dynamic>;
                        final date = expense['createdAt'] != null
                            ? (expense['createdAt'] as Timestamp)
                                .toDate()
                                .toString()
                                .split(' ')[0]
                            : '';
                        return Card(
                          margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? Color(0xFFffe9ec)
                                  : null,
                          child: SizedBox(
                            height: 80.0,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          expense['note'] ?? '',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          expense['date'] ?? '',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black54
                                                    : Colors.white70,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        Text(
                                          DateFormat.yMd().format(
                                              expense['createdAt'].toDate()),
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? Colors.black54
                                                    : Colors.white70,
                                            fontSize: 12.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: Text(
                                    '₹${expense['amount']?.toStringAsFixed(2) ?? ''}',
                                    style: TextStyle(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.deepPurple
                                          : Colors.purpleAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ))
                  ]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
