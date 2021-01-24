import 'package:flutter/material.dart';
import 'package:routing/done_module_list.dart';
import 'package:routing/module_list.dart';

class ModulePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memulai Pemrograman dengan Dart'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DoneModuleList()));
              })
        ],
      ),
      body: ModuleList(),
    );
  }
}
