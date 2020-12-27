import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  static const routeName = "ZOOM IN/OUT";

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage> {
  bool _isBig = true;
  double _size = 100;

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
            AnimatedContainer(
              duration: Duration(seconds: 1),
              color: Colors.blue,
              height: _size,
              width: _size,
            ),
            RaisedButton(
              child: Text('Animate'),
              onPressed: (){
                setState(() {
                  _size = _isBig ? 200 : 100;
                  _isBig = !_isBig;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}