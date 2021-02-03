import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class InputControl extends StatefulWidget {
  const InputControl({
    Key key,
  }) : super(key: key);

  @override
  _InputControlState createState() => _InputControlState();
}

class _InputControlState extends State<InputControl> {
  final controller = TextEditingController();
  String inputString;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            inputString = value;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: RaisedButton(
                onPressed: dispatchConcrete,
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: RaisedButton(
                onPressed: dispatchRandom,
                child: Text(
                  'Get Random',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.cyan,
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaForConcrateNumber(inputString),
    );
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(
      GetTriviaForRandomNumber(),
    );
  }
}
