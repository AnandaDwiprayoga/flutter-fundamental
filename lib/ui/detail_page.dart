import 'package:flutter/material.dart';
import 'package:routing/utils/received_notification.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  @override
  Widget build(BuildContext context) {
    final ReceivedNotification arg = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Title: ${arg.payload}'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back!'),
        ),
      ),
    );
  }
}
