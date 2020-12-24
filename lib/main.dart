import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Constrain',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/' : (context) => MainMenu(),
        ConstrainBehavior.CONSTRAINT_BEHAVIOR_ROUTE : (context) => ConstrainBehavior()
      },
    );
  }
}


class MainMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Constraint'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pushNamed(context, ConstrainBehavior.CONSTRAINT_BEHAVIOR_ROUTE);
              }, 
              child: Text('Constraint behavior')
            ),
            FlatButton(
              onPressed: (){
                Navigator.pushNamed(context, ConstrainBehavior.CONSTRAINT_BEHAVIOR_ROUTE);
              }, 
              child: Text('Constraint behavior')
            )
          ],
        ),
      ),
    );
  }
}

class ConstrainBehavior extends StatelessWidget {
  static const CONSTRAINT_BEHAVIOR_ROUTE = "constraint behavior route";

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Center(
      //container akan memiliki tinggi yang sama dengan childnya jika height dan width tidak didefinisikan
      //jika container tidak memiliki child dan tidak memiliki property height dan width maka lebarnya selayar
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10),
        child: Container(
          color: Colors.green,
          width: 100,
          height: 100,
          child: FlatButton(
            onPressed: () => Navigator.pop(context), 
            child: Text('Back')
          ),
        ),
      ),
    );
  }
}