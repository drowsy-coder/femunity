import 'package:femunity/features/posts/screens/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PeriodTrackerScreen extends StatefulWidget {
  @override
  _PeriodTrackerScreenState createState() => _PeriodTrackerScreenState();
}

class _PeriodTrackerScreenState extends State<PeriodTrackerScreen> {
  final TextEditingController _cycleController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _periodOn = false;
  DateTime? _selectedDate;
  DateTime? _nextPeriodDate;
  late String _userId;

  @override
  void initState() {
    super.initState();
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    if (user != null) {
      _userId = user.uid;
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _calculatePeriod() {
    if (_selectedDate != null &&
        _cycleController.text.isNotEmpty &&
        _periodController.text.isNotEmpty) {
      final int cycleLength = int.parse(_cycleController.text);
      final int periodLength = int.parse(_periodController.text);
      final Duration cycleDuration = Duration(days: cycleLength);
      final Duration periodDuration = Duration(days: periodLength);
      final DateTime periodStartDate = _selectedDate!;
      final DateTime periodEndDate =
          periodStartDate.add(periodDuration).subtract(Duration(days: 1));
      final DateTime nextPeriodStartDate = periodStartDate.add(cycleDuration);
      final DateTime nextPeriodEndDate =
          nextPeriodStartDate.add(periodDuration).subtract(Duration(days: 1));
      setState(() {
        _nextPeriodDate = nextPeriodStartDate;
      });
      _saveData();
    }
  }

  void _saveData() {
    FirebaseFirestore.instance
        .collection('period-tracker-data')
        .doc(DateTime.now().toIso8601String())
        .set({
          'userId': _userId,
          'cycleLength': _cycleController.text,
          'periodLength': _periodController.text,
          'periodOn': _periodOn,
          'periodStartDate': _selectedDate,
          'periodEndDate': _selectedDate
              ?.add(Duration(days: int.parse(_periodController.text) - 1)),
          'nextPeriodDate': _nextPeriodDate,
        })
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Data saved successfully'),
                backgroundColor: Colors.green,
              ),
            ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to save data: $error'),
                backgroundColor: Colors.red,
              ),
            ));
  }

  Widget _buildHealthTipsButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoryScreen()),
          );
        },
        child: Text('Health Tips'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Period Tracker'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Enter your period details:',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _cycleController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Cycle length (in days)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter cycle length';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: _periodController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Period length (in days)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter period length';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(
                      'Period started on: ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      _selectedDate == null
                          ? 'Please select a date'
                          : DateFormat('dd MMM yyyy').format(_selectedDate!),
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.pink,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_today),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Period on: ',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Switch(
                      value: _periodOn,
                      onChanged: (value) {
                        setState(() {
                          _periodOn = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
              if (_periodOn) _buildHealthTipsButton(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _calculatePeriod();
                    }
                  },
                  child: Text('Calculate'),
                ),
              ),
              if (_nextPeriodDate != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Your next period will start on: ${DateFormat('dd MMM yyyy').format(_nextPeriodDate!)}',
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
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

class HealthTipsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tips'),
      ),
      body: Center(
        child: Text(
          'Here are some health tips!',
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}
