import 'package:flutter/material.dart';
import 'package:routing/animation_page.dart';
import 'package:routing/animation_rotate.dart';
import 'package:routing/my_menu.dart';

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
      //jika menggunakan initialRoute tidak bisa menggunakan parameter home
     initialRoute: '/',
     routes: {
       MyMenu.routeName : (context) => MyMenu(),
       AnimationPage.routeName : (context) => AnimationPage(),
       AnimationRotate.routeName : (context) => AnimationRotate(),
     },
    );
  }
}
