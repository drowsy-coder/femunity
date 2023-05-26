import 'package:flutter/material.dart';

class ExerciseTipsScreen extends StatelessWidget {
  final List<String> _tips = [
    'Start small and gradually increase your activity level.',
    'Choose exercises that you enjoy to make it more fun.',
    'Find a workout buddy to keep you motivated.',
    'Listen to music or an audiobook while you exercise to make the time go by faster.',
    'Stretch before and after your workout to prevent injury.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Tips'),
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