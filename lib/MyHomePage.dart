import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final double boxSize = 150;
  int numTaps = 0;
  int numDoubleTaps = 0;
  int longTaps = 0;

  double posX = 0.0;
  double posY = 0.0;

  void makeCenterPosition(BuildContext context){
    posX = (MediaQuery.of(context).size.width / 2) - boxSize / 2;
    posY = (MediaQuery.of(context).size.height / 2) - boxSize / 2 - 30;

    setState(() {
      this.posX = posX;
      this.posY = posY;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(posX == 0){
      makeCenterPosition(context);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('Gesture Detector'),
        ),
        body: Stack(
          children: [
            Positioned(
              top: posY,
              left: posX,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    numTaps++;
                  });
                },
                onDoubleTap: (){
                  setState(() {
                    numDoubleTaps++;
                  });
                },
                onLongPress: (){
                  setState(() {
                    longTaps++;
                  });
                },
                // onVerticalDragUpdate: (DragUpdateDetails details){
                //   setState(() {
                //     double delta = details.delta.dy;
                //     
                //   });
                // },
                // onHorizontalDragUpdate: (DragUpdateDetails details){
                //   setState(() {
                //     double delta = details.delta.dx;
                //    
                //   });
                // },
                // karena jika menggunakan verticalDrag dan HorizontalDrag bersamaan
                // tidak dapat melakukan pergerakan ke sumbu z maka menggunakan onPanUpdate
                onPanUpdate: (DragUpdateDetails details){
                  setState(() {
                    double deltaY = details.delta.dy;
                    double deltaX = details.delta.dx;
                    
                    posY += deltaY;
                    posX += deltaX;
                  });
                },
                child: Container(
                  width: boxSize,
                  height: boxSize,
                  decoration: BoxDecoration(
                    color: Colors.red
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Colors.yellow,
          padding: const EdgeInsets.all(16),
          child: Text(
            "Taps : $numTaps - Double Taps: $numDoubleTaps - Long Press : $longTaps",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
    );
  }
}