import 'package:flutter/material.dart';

class StressTipsScreen extends StatelessWidget {
  final List<String> _tips = [
    'Practice deep breathing exercises to calm your mind.',
    'Take breaks throughout the day to rest and recharge.',
    'Get outside and enjoy nature to reduce stress levels.',
    'Talk to a trusted friend or family member about your feelings.',
    'Try meditation or yoga to help you relax and reduce stress.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stress Tips'),
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
