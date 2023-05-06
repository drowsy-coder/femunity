import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';

class StudyTimerScreen extends StatefulWidget {
  @override
  _StudyTimerScreenState createState() => _StudyTimerScreenState();
}

class _StudyTimerScreenState extends State<StudyTimerScreen> with TickerProviderStateMixin {
  static const int _defaultPomodoroTimeInSeconds = 25 * 60;
  static const int _defaultShortBreakTimeInSeconds = 5 * 60;
  static const int _defaultLongBreakTimeInSeconds = 15 * 60;
  static const int _defaultPomodoroCountBeforeLongBreak = 4;

  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _countdownTimer;
  late int _pomodoroTimeInSeconds;
  late int _shortBreakTimeInSeconds;
  late int _longBreakTimeInSeconds;
  late int _pomodoroCountBeforeLongBreak;
  int _remainingTimeInSeconds = _defaultPomodoroTimeInSeconds;
  bool _isRunning = false;
  bool _isPomodoro = true;
  int _pomodoroCount = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: _remainingTimeInSeconds),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);
    _pomodoroTimeInSeconds = _defaultPomodoroTimeInSeconds;
    _shortBreakTimeInSeconds = _defaultShortBreakTimeInSeconds;
    _longBreakTimeInSeconds = _defaultLongBreakTimeInSeconds;
    _pomodoroCountBeforeLongBreak = _defaultPomodoroCountBeforeLongBreak;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _animationController.duration = Duration(seconds: _remainingTimeInSeconds);
    _animationController.reverse(from: _animation.value == 0.0 ? 1.0 : _animation.value);
    _countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTimeInSeconds--;
      });
      if (_remainingTimeInSeconds <= 0) {
        timer.cancel();
        _isRunning = false;
        _isPomodoro = !_isPomodoro;
        if (_isPomodoro) {
          _pomodoroCount++;
        }
        _remainingTimeInSeconds = _isPomodoro ? _pomodoroTimeInSeconds : (_pomodoroCount % _pomodoroCountBeforeLongBreak == 0 ? _longBreakTimeInSeconds : _shortBreakTimeInSeconds);
        _showNotification();
        _startTimer();
      }
    });
    _isRunning = true;
  }

  void _resetTimer() {
    _countdownTimer?.cancel();
    _animationController.stop();
    _remainingTimeInSeconds = _isPomodoro ? _pomodoroTimeInSeconds : (_pomodoroCount % _pomodoroCountBeforeLongBreak == 0 ? _longBreakTimeInSeconds : _shortBreakTimeInSeconds);
    _animationController.duration = Duration(seconds: _remainingTimeInSeconds);
    setState(() {});
  }

  void _showNotification() async {
    const platform = MethodChannel('flutter_native_notifications');
    try {
      await platform.invokeMethod('showNotification');
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onPomodoroTimeChanged(double value) {
    setState(() {
      _pomodoroTimeInSeconds = value.round() * 60;
    });
    if (!_isRunning && _isPomodoro) {
      _resetTimer();
    }
  }

  void _onShortBreakTimeChanged(double value) {
    setState(() {
      _shortBreakTimeInSeconds = value.round() * 60;
    });
    if (!_isRunning && !_isPomodoro && _pomodoroCount % _pomodoroCountBeforeLongBreak != 0) {
      _resetTimer();
    }
  }

  void _onLongBreakTimeChanged(double value) {
    setState(() {
      _longBreakTimeInSeconds = value.round() * 60;
    });
    if (!_isRunning && !_isPomodoro && _pomodoroCount % _pomodoroCountBeforeLongBreak == 0) {
      _resetTimer();
    }
  }

  void _onPomodoroCountBeforeLongBreakChanged(double value) {
    setState(() {
      _pomodoroCountBeforeLongBreak = value.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingTimeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTimeInSeconds % 60).toString().padLeft(2, '0');
    final timeString = '$minutes:$seconds';

    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro Timer'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green[700]!,
              Colors.black!,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200.0,
              height: 200.0,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: ClockPainter(
                        animation: _animation,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      timeString,
                      style: TextStyle(
                        fontSize: 48.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TextButton(
                //   onPressed: _isPomodoro ? null : _resetTimer,
                //   // child: Text(
                //   //   'Short Break',
                //   //   style: TextStyle(
                //   //     color: _isPomodoro ? Colors.grey[400] : Colors.white,
                //   //   ),
                //   // ),
                // ),
                SizedBox(width: 20.0),
                TextButton(
                  onPressed: !_isPomodoro ? null : _resetTimer,
                  child: Text(
                    'Pomodoro',
                    style: TextStyle(
                      color: !_isPomodoro ? Colors.grey[400] : Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(width: 20.0),
                // TextButton(
                //   onPressed: _isPomodoro ? null : _resetTimer,
                //   // child: Text(
                //   //   'Long Break',
                //   //   style: TextStyle(
                //   //     color: _isPomodoro ? Colors.grey[400] : Colors.white,
                //   //   ),
                //   // ),
                // ),
              ],
            ),
            SizedBox(height: 20.0),
            Text('Pomodoro Time'),
            Slider(
              value: _pomodoroTimeInSeconds / 60,
              min: 1,
              max: 60,
              onChanged: _isRunning ? null : _onPomodoroTimeChanged,
            ),
            // Text('Short Break Time'),
            // Slider(
            //   value: _shortBreakTimeInSeconds / 60,
            //   min: 1,
            //   max: 60,
            //   onChanged: _isRunning || _isPomodoro ? null : _onShortBreakTimeChanged,
            // ),
            // Text('Long Break Time'),
            // Slider(
            //   value: _longBreakTimeInSeconds / 60,
            //   min: 1,
            //   max: 60,
            //   onChanged: _isRunning || _isPomodoro ? null : _onLongBreakTimeChanged,
            // ),
            // Text('Pomodoro Count Before Long Break'),
            // Slider(
            //   value: _pomodoroCountBeforeLongBreak.toDouble(),
            //   min: 1,
            //   max: 10,
            //   onChanged: _isRunning || _isPomodoro ? null : _onPomodoroCountBeforeLongBreakChanged,
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isRunning ? null : _startTimer,
        child: Icon(Icons.play_arrow),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class ClockPainter extends CustomPainter {
  ClockPainter({required this.animation})
      : super(repaint: animation);

  final Animation<double> animation;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10.0;

    canvas.drawCircle(center, radius, paint);

    final double progress = (1.0 - animation.value) * 2 * 3.14;

    final double x = center.dx + radius * sin(progress);
    final double y = center.dy - radius * cos(progress);

    final paint2 = Paint()
      ..color = Colors.green[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    canvas.drawLine(center, Offset(x, y), paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}