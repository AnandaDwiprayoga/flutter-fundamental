import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:routing/features/number_trivia/depedency_injection_container.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:routing/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:routing/features/number_trivia/presentation/widgets/input_control.dart';
import 'package:routing/features/number_trivia/presentation/widgets/loading_display.dart';
import 'package:routing/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:routing/features/number_trivia/presentation/widgets/trivia_display.dart';

class NumberTriviapage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(child: _buildBlocProvider(context)),
    );
  }
}

BlocProvider<NumberTriviaBloc> _buildBlocProvider(BuildContext context) {
  return BlocProvider(
    create: (_) => getInstance<NumberTriviaBloc>(),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
              builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(
                    text: 'Start Searching',
                  );
                } else if (state is Loading) {
                  return LoadingDisplay();
                } else if (state is Loaded) {
                  return TriviaDisplay(numberTrivia: state.trivia);
                } else if (state is Error) {
                  return MessageDisplay(
                    text: state.message,
                  );
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            InputControl()
          ],
        ),
      ),
    ),
  );
}
