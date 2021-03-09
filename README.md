# Brightness
A Flutter plugin to control brightness of the device's screen on Android and iOS.

## Usage
To use this plugin, add `brightness` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).


## Example
``` dart
// Import package
import 'package:birghtness/birghtness.dart';

// Get the current brightness:
double brightness = await Screen.brightness;

// Set the brightness:
Screen.setBrightness(0.5);
```
## Origin

Originally, this plugin was based on [`screen`](https://pub.dev/packages/screen).  
Specifically, the brightness functionality was extracted into this plugin due to lack of maintenance
by the author of the `screen` plugin.

Today, the `brightness` plugin has been completely refreshed.