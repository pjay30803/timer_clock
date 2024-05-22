import 'dart:async';
import 'package:flutter/material.dart';
import 'package:timer/analogwatch.dart';

void main() {runApp(const TimerWatchScreen());}

class TimerWatchScreen extends StatelessWidget {
  const TimerWatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Timer Clock',
      debugShowCheckedModeBanner: false,
      home: TimerPage(),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late TextEditingController _hoursController;
  late TextEditingController _minutesController;
  late TextEditingController _secondsController;

  late int hours;
  late int minutes;
  late int seconds;
  late int totalSeconds;

  bool isRunning = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _hoursController = TextEditingController();
    _minutesController = TextEditingController();
    _secondsController = TextEditingController();
    hours = 0;
    minutes = 0;
    seconds = 0;
    totalSeconds = 0;
  }

  @override
  void dispose() {
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Clock'),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder:(context) => MyApp()));
          }, icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _hoursController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Hours',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        hours = int.tryParse(value) ?? 0;
                        updateTotalSeconds();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _minutesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Minutes',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        minutes = int.tryParse(value) ?? 0;
                        updateTotalSeconds();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 80,
                  child: TextField(
                    controller: _secondsController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Seconds',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        seconds = int.tryParse(value) ?? 0;
                        updateTotalSeconds();
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: isRunning ? null : startTimer,
                  child: Text('Start'),
                ),
                ElevatedButton(
                  onPressed: isRunning ? stopTimer : null,
                  child: Text('Stop'),
                ),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Reset'),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              formatTime(totalSeconds),
              style: TextStyle(fontSize: 48.0),
            ),
          ],
        ),
      ),
    );
  }

  void updateTotalSeconds() {
    totalSeconds = hours * 3600 + minutes * 60 + seconds;
  }

  void startTimer() {
    setState(() {
      isRunning = true;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (totalSeconds > 0) {
          totalSeconds--;
        } else {
          timer.cancel();
          isRunning = false;
        }
      });
    });
  }

  void stopTimer() {
    setState(() {
      isRunning = false;
      _timer.cancel();
    });
  }

  void resetTimer() {
    setState(() {
      isRunning = false;
      totalSeconds = 0;
      _hoursController.clear();
      _minutesController.clear();
      _secondsController.clear();
    });
  }

  String formatTime(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (remainingSeconds).toString().padLeft(2, '0');
    return '$hoursStr:$minutesStr:$secondsStr';
  }
}
