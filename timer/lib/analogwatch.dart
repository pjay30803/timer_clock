import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:timer/timerwatch.dart';
import 'package:timer/stopwatch.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AnalogClockScreen(),
    );
  }
}

class AnalogClockScreen extends StatelessWidget {
  const AnalogClockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analog Clock Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.timer),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TimerWatchScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.timer_off),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StopWatchScreen()));
            },
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: AnalogClock(
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.black),
              color: Colors.transparent,
              shape: BoxShape.circle,
            ),
            isLive: true,
            hourHandColor: Colors.black,
            minuteHandColor: Colors.black,
            secondHandColor: Colors.red,
            showNumbers: true,
            showTicks: true,
          ),
        ),
      ),
    );
  }
}

class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Screen'),
      ),
      body: Center(
        child: Text('Timer Screen'),
      ),
    );
  }
}

class StopwatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch Screen'),
      ),
      body: Center(
        child: Text('Stopwatch Screen'),
      ),
    );
  }
}