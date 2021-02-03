import 'dart:convert';

import 'package:matcher/matcher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:routing/core/errors/exceptions.dart';
import 'package:routing/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:routing/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  NumberTriviaRemoteDataSourceImpl dataSourceImpl;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSourceImpl = NumberTriviaRemoteDataSourceImpl(client: mockHttpClient);
  });

  void setUpMockHttpClientSuccess() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response(fixtures('trivia.json'), 200));
  }

  void setUpMockHttpClientFailure() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getConcreteNumberTrivia', () {
    final tNumber = 1;
    final expectedResult =
        NumberTriviaModel.fromJson(json.decode(fixtures('trivia.json')));

    test(
      'should perform a GET request on a URL with number being the endpoint and with application/json header',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        dataSourceImpl.getConcreteNumberTrivia(tNumber);
        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/$tNumber',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        final result = await dataSourceImpl.getConcreteNumberTrivia(tNumber);
        // assert
        expect(result, equals(expectedResult));
      },
    );

    test(
      'should return ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure();
        // act
        final result = dataSourceImpl.getConcreteNumberTrivia;
        // assert
        expect(() => result(tNumber), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });

  //  -------=============== RANDOM TRIVIA TEST ===============------- //

  group('getRandomNumberTrivia', () {
    final expectedResult =
        NumberTriviaModel.fromJson(json.decode(fixtures('trivia.json')));

    test(
      'should perform a GET request on a URL with number being the endpoint and with application/json header',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        dataSourceImpl.getRandomNumberTrivia();
        // assert
        verify(mockHttpClient.get(
          'http://numbersapi.com/random',
          headers: {'Content-Type': 'application/json'},
        ));
      },
    );

    test(
      'should return NumberTrivia when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess();
        // act
        final result = await dataSourceImpl.getRandomNumberTrivia();
        // assert
        expect(result, equals(expectedResult));
      },
    );

    test(
      'should return ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure();
        // act
        final result = dataSourceImpl.getRandomNumberTrivia;
        // assert
        expect(() => result(), throwsA(TypeMatcher<ServerException>()));
      },
    );
  });
}
