import 'package:flutter/material.dart';
import 'package:brightness/brightness.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp();

  @override
  _MyAppState createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _isKeptOn = false;
  double _brightness = 1.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() async {
    double brightness = await Screen.brightness;
    setState(() {
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Screen plugin example')),
            body: Center(
                child: Column(children: <Widget>[
              Text("Brightness :"),
              Slider(
                  value: _brightness,
                  onChanged: (double b) {
                    setState(() {
                      _brightness = b;
                    });
                    Screen.setBrightness(b);
                  })
            ]))));
  }
}
