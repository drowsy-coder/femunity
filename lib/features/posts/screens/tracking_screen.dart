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
                backgroundColor: Color(0xFFffe9ec),
              ),
            ))
        .catchError((error) => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to save data: $error'),
                backgroundColor: Color(0xFFffe9ec),
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
            MaterialPageRoute(builder: (context) => HealthTipsScreen()),
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.pink),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.pink),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite,
                color: Colors.white,
              ),
              SizedBox(width: 8.0),
              Text(
                'Health Tips',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Period Tracking',
          style: Theme.of(context).textTheme.headline6?.copyWith(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900] // set color for dark mode
            : Color(0xFFffe9ec),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HistoryScreen()),
              );
            },
          ),
        ],
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
                  style: TextStyle(
                      fontFamily: 'DancingScript',
                      fontSize: 24.0,
                      color: Colors.pink),
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
                  style: TextStyle(fontFamily: 'Roboto'),
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
                  style: TextStyle(fontFamily: 'Roboto'),
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
                      style: TextStyle(
                          fontFamily: 'DancingScript', fontSize: 18.0),
                    ),
                    Text(
                      _selectedDate == null
                          ? 'Please select a date'
                          : DateFormat('dd MMM yyyy').format(_selectedDate!),
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_today, color: Colors.green),
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
                      'Are you on your period? ',
                      style: TextStyle(
                          fontFamily: 'DancingScript', fontSize: 18.0),
                    ),
                    Switch(
                      value: _periodOn,
                      onChanged: (value) {
                        setState(() {
                          _periodOn = value;
                        });
                      },
                      activeColor: Colors.yellow,
                      inactiveTrackColor: Colors.grey[400],
                      inactiveThumbColor: Colors.white,
                      activeTrackColor: Colors.pink[100],
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  ],
                ),
              ),
              if (_periodOn) _buildHealthTipsButton(),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculatePeriod();
                      }
                    },
                    child: Text('Calculate',
                        style: TextStyle(
                            fontFamily: 'DancingScript', fontSize: 24.0)),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                  ),
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
        title: Text('Female Health Tips'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPermanentFactsCard(),
            SizedBox(height: 16),
            _buildHealthGuideCard(
              title: 'Healthy eating',
              imageUrl:
                  'https://images.everydayhealth.com/images/ces-trends-to-watch-2022-1440x810.jpg',
              onTap: () {
                // TODO: Navigate to healthy eating guide
              },
            ),
            SizedBox(height: 16),
            _buildHealthGuideCard(
              title: 'Fitness exercises',
              imageUrl:
                  'https://images.everydayhealth.com/images/ces-trends-to-watch-2022-1440x810.jpg',
              onTap: () {
                // TODO: Navigate to fitness exercises guide
              },
            ),
            SizedBox(height: 16),
            _buildHealthGuideCard(
              title: 'Stress management',
              imageUrl:
                  'https://images.everydayhealth.com/images/ces-trends-to-watch-2022-1440x810.jpg',
              onTap: () {
                // TODO: Navigate to stress management guide
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPermanentFactsCard() {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Permanent Facts',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.purpleAccent,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Here are some permanent facts about women health and hygiene that you should always keep in mind:',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[200],
              ),
            ),
            SizedBox(height: 24),
            _buildFactItem(
              '- Drink plenty of water to stay hydrated',
              Icons.local_drink,
            ),
            SizedBox(height: 16),
            _buildFactItem(
              '- Eat a healthy and balanced diet',
              Icons.food_bank,
            ),
            SizedBox(height: 16),
            _buildFactItem(
              '- Exercise regularly to maintain good health',
              Icons.fitness_center,
            ),
            SizedBox(height: 16),
            _buildFactItem(
              '- Manage stress through relaxation techniques',
              Icons.spa,
            ),
            SizedBox(height: 16),
            _buildFactItem(
              '- Get enough sleep to recharge your body and mind',
              Icons.nightlight_round,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFactItem(String text, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.purpleAccent,
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[200],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHealthGuideCard({
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              child: Image.network(
                imageUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.purpleAccent,
                ),
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
