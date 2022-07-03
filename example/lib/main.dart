import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:simple_pedometer/simple_pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _steps = 0;

  @override
  void initState() {
    super.initState();
    getSteps();
  }

  Future<void> getSteps() async {
    int stepsInLast4Hours;

    final sensorsPermission = await Permission.sensors.request();

    if (sensorsPermission.isDenied) {
      return;
    }

    try {
      stepsInLast4Hours = await SimplePedometer.getSteps(
        from: DateTime.now().add(const Duration(hours: -4)),
        to: DateTime.now(),
      );
    } on PlatformException {
      stepsInLast4Hours = 0;
    }
    if (!mounted) return;

    setState(() {
      _steps = stepsInLast4Hours;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Steps in last 4 hours: $_steps\n'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            getSteps();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
