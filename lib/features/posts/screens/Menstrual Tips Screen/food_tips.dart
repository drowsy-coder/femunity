import 'package:flutter/material.dart';

class FoodTipsScreen extends StatelessWidget {
  final List<String> _tips = [
    'Drink plenty of water to stay hydrated.',
    'Eat a balanced diet with plenty of fruits and vegetables.',
    'Get enough sleep each night.',
    'Exercise regularly to keep your body healthy.',
    'Wash your hands frequently to avoid getting sick.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tips'),
      ),
      body: ListView.builder(
        itemCount: _tips.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_tips[index]),
          );
        },
      ),
    );
  }
}
