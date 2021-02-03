import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:routing/core/utils/input_converter.dart';

void main() {
  InputConverter inputConverter;

  setUp(() {
    inputConverter = InputConverter();
  });

  group('stringToUnsignedInt', () {
    test(
      'should return int value when input string is integer',
      () async {
        // arrange
        final String inputTest = '123';
        // act
        final result = inputConverter.stringToUnsignedInt(inputTest);
        // assert
        expect(result, equals(Right(123)));
      },
    );

    test(
      'should return Failure when input string is not integer or double',
      () async {
        // arrange
        final String inputTest = 'abc';
        // act
        final result = inputConverter.stringToUnsignedInt(inputTest);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );

    test(
      'should return Failure when input string is negative integer',
      () async {
        // arrange
        final String inputTest = '-123';
        // act
        final result = inputConverter.stringToUnsignedInt(inputTest);
        // assert
        expect(result, Left(InvalidInputFailure()));
      },
    );
  });
}
