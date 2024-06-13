import 'package:db/weight/route/ARoute.dart';
import 'package:db/weight/splashWeight.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  ARoute.initARoute();
  print("zhy^_^ initARoute");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 隐藏状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Scaffold(
        // body: TestWeight(),
        body: splash(),
      ),
    );
  }
}
