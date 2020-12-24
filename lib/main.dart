import 'package:flutter/material.dart';
import 'package:routing/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesture Detector',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      //jika menggunakan initialRoute tidak bisa menggunakan parameter home
      initialRoute: '/',
      home: MyHomePage(),
    );
  }
}
