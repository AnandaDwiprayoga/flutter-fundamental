import 'package:flutter/material.dart';

class FirstScreen extends StatelessWidget {

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Navigation & Routing'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Go to Second Screen'),
                onPressed: (){
                  //normal navigation menggunakan Navigator.push/pop
                  Navigator.pushNamed(context, '/secondScreen');
                }
              ),
              RaisedButton(
                child: Text('Navigation with Data'),
                onPressed: (){
                  Navigator.pushNamed(context, '/secondScreenWithData', arguments: 'Hello from first Screen!');
                }
              ),
              RaisedButton(
                child: Text('Return Data from another Screen'),
                onPressed: () async {
                  //menggunakan async await karena pushNamed adalah future, artinya mengembalikan nilai
                  //jadi alangkah baiknya menggunakan await untuk menunggu nilai kembalian
                  final result = await Navigator.pushNamed(context, '/returnDataScreen');
                  SnackBar snackBar = SnackBar(content: Text(result));
                  //karna snackbar adalah komponen material design jadi membutuhkan
                  //context dari scaffold kemudian menambahkan parameter key di scaffold widget
                  //sebagai identifier nya
                  _scaffoldKey.currentState.showSnackBar(snackBar);
                }
              ),
              RaisedButton(
                child: Text('Replace Screen'),
                onPressed: (){
                  Navigator.pushNamed(context, '/replacementScreen');
                }
              )
            ],
          ),
        ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RaisedButton(
            child: Text('Back'),
            onPressed: (){
              //normal navigation
               Navigator.pop(context);
            }
          ),
        ),
    );
  }
}


class SecondScreenWithData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //ModalRoute.of() sama seperti intent.getXxx jika di android
    final String data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text(data),
                RaisedButton(
                  child: Text('Back'),
                  onPressed: (){
                    Navigator.pop(context);
                  }
                ),
            ],
          ),
        ),
    );
  }
}


class ReturnDataScreen extends StatelessWidget {

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: textController,
                decoration: InputDecoration(labelText: 'Enter your name'),
              ),
            ),
            RaisedButton(
              child: Text('Send'),
              onPressed: (){
                Navigator.pop(context, textController.text);
              }
            )
          ],
        ),
      ),
    );
  }
}

class ReplacementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Open Another Screen'),
          onPressed: (){
            //pushreplacement seperti fragment tetapi tidak addToBackStage
            Navigator.pushReplacementNamed(context, '/anotherScreen');
          }
        ),
      ),
    );
  }
}

class AnotherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Back to First Screen'),
            RaisedButton(
              child: Text('Back'),
              onPressed: (){
                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
    );
  }
}