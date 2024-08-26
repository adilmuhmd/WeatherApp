import 'package:flutter/material.dart';
import 'package:weatherapp/weatherHomePage.dart';
import 'package:weatherapp/weathersample.dart';

void main() {
  runApp(const sample());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: weatherHomePage(),
    );
  }
}
