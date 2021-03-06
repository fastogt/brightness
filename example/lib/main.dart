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
  double? _brightness = 1.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void initPlatformState() async {
    _brightness = await ScreenBrightness.value;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Brightness plugin example')),
            body: Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              const Text("Brightness :"),
              Slider(
                  value: _brightness!,
                  onChanged: (double b) {
                    setState(() {
                      _brightness = b;
                    });
                    ScreenBrightness.set(b);
                  })
            ]))));
  }
}
