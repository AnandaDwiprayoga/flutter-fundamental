import 'package:flutter/material.dart';
import './features/number_trivia/depedency_injection_container.dart' as di;
import 'features/number_trivia/presentation/pages/number_trivia_page.dart';

void main() async {
  // because this main is asycn so need to add ensureInitialized
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Route',
      theme: ThemeData(primaryColor: Colors.blue),
      home: NumberTriviapage(),
    );
  }
}
