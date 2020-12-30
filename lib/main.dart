import 'package:flutter/cupertino.dart';
import 'package:routing/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      theme: CupertinoThemeData(
        primaryColor: CupertinoColors.systemOrange
      ),
      home: HomePage(),
    );
  }
}
