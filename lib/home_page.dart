import 'package:flutter/cupertino.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino App'),
      ),
      child: Center(
        child: Text(
          'Home Page',
          style: CupertinoTheme.of(context).textTheme.navActionTextStyle,
        ),
      ),
    );
  }
}