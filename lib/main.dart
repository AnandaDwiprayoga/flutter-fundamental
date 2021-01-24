import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:routing/module_page.dart';
import 'package:routing/provider/done_module_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // to wrap all widget with provider state
    return ChangeNotifierProvider(
      create: (context) => DoneModuleProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity),
        home: ModulePage(),
      ),
    );
  }
}
