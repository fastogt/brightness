
import 'dart:async';

import 'package:flutter/services.dart';

class Brightness {
  static const MethodChannel _channel =
      const MethodChannel('brightness');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
