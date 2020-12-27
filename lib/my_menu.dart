import 'package:flutter/material.dart';
import 'package:routing/animation_page.dart';
import 'package:routing/animation_rotate.dart';

class MyMenu extends StatelessWidget {
  
  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              child: Text('AnimatedFoo'),
              onPressed: (){
                Navigator.pushNamed(context, AnimationPage.routeName);
              },
            ),
            RaisedButton(
              child: Text('Tween Animations'),
              onPressed: (){
                Navigator.pushNamed(context, AnimationRotate.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}