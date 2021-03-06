import 'dart:async';

import 'package:flutter/services.dart';

class ScreenBrightness {
  static const MethodChannel _channel = const MethodChannel('github.com/fastogt/brightness');

  static Future<double?> get value async {
    return (await _channel.invokeMethod('brightness')) as double?;
  }

  static Future<void> set(double brightness) {
    return _channel.invokeMethod('setBrightness', {"brightness": brightness});
  }
}
