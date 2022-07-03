import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class SimplePedometer {
  static const MethodChannel _channel = MethodChannel('simple_pedometer');

  static Future<int> getTodaysSteps() async {
    final now = DateTime.now();
    final todayStartedAt = now.add(
        Duration(hours: -now.hour, minutes: -now.minute, seconds: -now.second));
    return getSteps(from: todayStartedAt, to: now);
  }

  static Future<int> getSteps({
    required DateTime from,
    required DateTime to,
  }) async {
    if (!Platform.isIOS) {
      assert(false, 'This plugin only supports iOS');
      return 0;
    }
    final args = <String, dynamic>{
      'startTime': from.millisecondsSinceEpoch,
      'endTime': to.millisecondsSinceEpoch
    };
    final res = await _channel.invokeMethod<int>(
      'getSteps',
      args,
    ) ??
        0;
    return res;
  }
}
