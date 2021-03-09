import 'dart:async';

import 'package:flutter/services.dart';

class Screen {
  static const MethodChannel _channel = const MethodChannel('github.com/fastogt/brightness');

  static Future<double> get brightness async {
    return (await _channel.invokeMethod('brightness')) as double;
  }

  static Future<void> setBrightness(double brightness) {
    return _channel.invokeMethod('setBrightness', {"brightness": brightness});
  }
}
