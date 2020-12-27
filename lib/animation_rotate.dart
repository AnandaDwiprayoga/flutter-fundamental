import 'dart:math';

import 'package:flutter/material.dart';

class AnimationRotate extends StatefulWidget {
  static const routeName = "AnimationRotateRoute";

  @override
  _AnimationRotateState createState() => _AnimationRotateState();
}

class _AnimationRotateState extends State<AnimationRotate> {
  
  double _size = 100;
  Tween _animationTween = Tween<double>(begin: 0, end: pi * 2);
  Tween _colorTween = ColorTween(begin:Colors.blue, end: Colors.purple);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder<double>(
              tween: _animationTween,
              duration: Duration(seconds: 3),
              builder: (context, double value, child){
                return Transform.rotate(
                  angle: value,
                  child: Container(
                    color: Colors.blue,
                    height: _size,
                    width: _size,
                  ),
                );
              },
            ),
            SizedBox(height: 20,),
            TweenAnimationBuilder<Color>(
              tween: _colorTween,
              duration: Duration(seconds: 3),
              builder: (context, Color value, child){
                return Container(
                  color: value,
                  height: _size,
                  width: _size,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}