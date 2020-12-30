import 'package:flutter/material.dart';
import 'package:routing/learningpath_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Route',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
     home: LearningPathPage(),
    );
  }
}
