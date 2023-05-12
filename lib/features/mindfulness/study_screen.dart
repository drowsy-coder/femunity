import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PomodoroScreen extends StatefulWidget {
  @override
  _PomodoroScreenState createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  Duration _pomodoroDuration = Duration(minutes: 25);
  Duration _shortBreakDuration = Duration(minutes: 5);
  Duration _longBreakDuration = Duration(minutes: 15);
  int _pomodoroCount = 0;
  Timer? _timer;
  Duration _timeLeft = Duration();
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _timeLeft = _pomodoroDuration;
  }

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft.inSeconds == 0) {
          timer.cancel();
          _pomodoroCount++;
          if (_pomodoroCount % 4 == 0) {
            _timeLeft = _longBreakDuration;
          } else {
            _timeLeft = _shortBreakDuration;
          }
        } else {
          _timeLeft = Duration(seconds: _timeLeft.inSeconds - 1);
        }
      });
    });
  }

  void pauseTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _isRunning = false;
    });
  }

  void resetTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _pomodoroCount = 0;
      _timeLeft = _pomodoroDuration;
      _isRunning = false;
    });
  }

  void setDuration(Duration duration) {
    setState(() {
      _timeLeft = duration;
      if (!_isRunning) {
        _pomodoroDuration = duration;
      } else if (_pomodoroCount % 4 == 0) {
        _longBreakDuration = duration;
      } else {
        _shortBreakDuration = duration;
      }
      resetTimer();
    });
  }

  String get congratulatoryText {
    if (_pomodoroCount % 4 == 0) {
      return 'Great job! You completed a long break.';
    } else {
      return 'Great job! You completed a pomodoro session.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Study Timer'),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/images/pomodorotimer.png',
                  height: 200,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Pomodoro Timer',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '${_timeLeft.inMinutes.toString().padLeft(2, '0')}:${(_timeLeft.inSeconds % 60).toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _isRunning
                            ? ElevatedButton(
                                onPressed: pauseTimer,
                                child: Text(
                                  'Pause',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ElevatedButton(
                                onPressed: startTimer,
                                child: Text(
                                  'Start',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: resetTimer,
                          child: Text(
                            'Reset',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 200,
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.hm,
                                initialTimerDuration: _timeLeft,
                                onTimerDurationChanged: (Duration duration) {
                                  setDuration(duration);
                                },
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Change Duration',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    if (_timeLeft.inSeconds == 0)
                      Text(
                        congratulatoryText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}