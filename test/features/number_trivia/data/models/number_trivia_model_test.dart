import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:routing/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tNumberTrivia = NumberTriviaModel(number: 1, text: 'Test Text');

  test(
    'should be a subclass of number trivia entity',
    () {
      // assert
      expect(tNumberTrivia, isA<NumberTrivia>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the json number is integer',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixtures('trivia.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, equals(tNumberTrivia));
      },
    );

    test(
      'should return a valid model when the json number is double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap =
            json.decode(fixtures('trivia_double.json'));
        // act
        final result = NumberTriviaModel.fromJson(jsonMap);
        // assert
        expect(result, equals(tNumberTrivia));
      },
    );
  });

  group('toJson', () {
    test('Should return a json map containing the proper data', () {
      final result = tNumberTrivia.toJson();

      final expectedResult = {
        "text": "Test Text",
        "number": 1,
      };
      expect(result, expectedResult);
    });
  });
}
