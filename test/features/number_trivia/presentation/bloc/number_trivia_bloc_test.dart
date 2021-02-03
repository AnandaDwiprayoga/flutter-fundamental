import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:routing/core/errors/failure.dart';
import 'package:routing/core/utils/input_converter.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:routing/features/number_trivia/domain/usecases/get_concrate_number_trivia.dart';
import 'package:routing/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:routing/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';

class MockGetConcrateNumberTrivia extends Mock
    implements GetConcrateNumberTrivia {}

class MockGetRandomNumberTrivia extends Mock implements GetRandomNumberTrivia {}

class MockInputConverter extends Mock implements InputConverter {}

void main() {
  NumberTriviaBloc bloc;
  MockGetConcrateNumberTrivia mockGetConcrateNumberTrivia;
  MockGetRandomNumberTrivia mockGetRandomNumberTrivia;
  MockInputConverter mockInputConverter;

  setUp(() {
    mockGetConcrateNumberTrivia = MockGetConcrateNumberTrivia();
    mockGetRandomNumberTrivia = MockGetRandomNumberTrivia();
    mockInputConverter = MockInputConverter();

    bloc = NumberTriviaBloc(
      getConcrateNumberTrivia: mockGetConcrateNumberTrivia,
      getRandomNumberTrivia: mockGetRandomNumberTrivia,
      inputConverter: mockInputConverter,
    );
  });

  test('should return empty in initialState', () {
    expect(bloc.state, equals(Empty()));
  });

  group('GetTriviaForConcrateNumber', () {
    final tNumberString = '1';
    final tNumberParsed = 1;
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test text');

    void arrangeInputConverterSuccess() =>
        when(mockInputConverter.stringToUnsignedInt(any))
            .thenReturn(Right(tNumberParsed));
    test(
      'should call the input converter to validate input',
      () async {
        // arrange
        arrangeInputConverterSuccess();
        // act
        bloc.add(GetTriviaForConcrateNumber(tNumberString));
        // because block dispatch/add is async so we must to wait until action in dispatch called
        await untilCalled(mockInputConverter.stringToUnsignedInt(any));
        // assert
        verify(mockInputConverter.stringToUnsignedInt(tNumberString));
      },
    );

    test(
      'should emit [error] when the input is invalid',
      () async {
        // arrange
        when(mockInputConverter.stringToUnsignedInt(any))
            .thenReturn(Left(InvalidInputFailure()));
        // assert later because bloc is return stream so must white wait
        final expected = [
          Error(message: INVALID_INPUT_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcrateNumber(tNumberString));
      },
    );

    test(
      'should get data from the concrate use case',
      () async {
        // arrange
        arrangeInputConverterSuccess();
        when(mockGetConcrateNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForConcrateNumber(tNumberString));
        await untilCalled(mockGetConcrateNumberTrivia(any));
        // assert
        verify(mockGetConcrateNumberTrivia(Params(tNumberParsed)));
      },
    );

    test(
      'should emit [Loading,Loaded] when data is gotten successfully',
      () async {
        // arrange
        arrangeInputConverterSuccess();
        when(mockGetConcrateNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // assert later
        final expectedState = [
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc, emitsInOrder(expectedState));
        // act
        bloc.add(GetTriviaForConcrateNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        // arrange
        arrangeInputConverterSuccess();
        when(mockGetConcrateNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcrateNumber(tNumberString));
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        // arrange
        arrangeInputConverterSuccess();
        when(mockGetConcrateNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForConcrateNumber(tNumberString));
      },
    );
  });

// FOR RANDOM TRIVIA

  group('GetTriviaForRandomNumber', () {
    final tNumberTrivia = NumberTrivia(number: 1, text: 'test text');

    test(
      'should get data from the random use case',
      () async {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // act
        bloc.add(GetTriviaForRandomNumber());
        await untilCalled(mockGetRandomNumberTrivia(any));
        // assert
        verify(mockGetRandomNumberTrivia(NoParams()));
      },
    );

    test(
      'should emit [Loading,Loaded] when data is gotten successfully',
      () async {
        // arrange
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Right(tNumberTrivia));
        // assert later
        final expectedState = [
          Loading(),
          Loaded(trivia: tNumberTrivia),
        ];
        expectLater(bloc, emitsInOrder(expectedState));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] when getting data fails',
      () async {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(ServerFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: SERVER_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );

    test(
      'should emit [Loading, Error] with a proper message for the error when getting data fails',
      () async {
        when(mockGetRandomNumberTrivia(any))
            .thenAnswer((_) async => Left(CacheFailure()));
        // assert later
        final expected = [
          Loading(),
          Error(message: CACHE_FAILURE_MESSAGE),
        ];
        expectLater(bloc, emitsInOrder(expected));
        // act
        bloc.add(GetTriviaForRandomNumber());
      },
    );
  });
}
