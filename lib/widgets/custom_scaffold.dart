import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;

  CustomScaffold({this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [body, BuildShortAppWidget()],
      )),
    );
  }
}

class BuildShortAppWidget extends StatelessWidget {
  const BuildShortAppWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(16))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              'N',
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        ],
      ),
    );
  }
}
