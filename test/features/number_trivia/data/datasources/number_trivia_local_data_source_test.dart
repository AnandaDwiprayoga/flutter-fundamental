import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:routing/core/errors/exceptions.dart';
import 'package:routing/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:routing/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'package:matcher/matcher.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl dataSourceImpl;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSourceImpl = NumberTriviaLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixtures('trivia_cache.json')));

    test(
      'should return NumberTrivia from sharedpreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixtures('trivia_cache.json'));
        // act
        final result = await dataSourceImpl.getLastNumberTrivia();
        // assert
        verify(mockSharedPreferences.getString(CACHED_NUMBER_KEY));
        expect(result, equals(tNumberTriviaModel));
      },
    );

    test(
      'should return a CacheException from sharedpreferences when there is no one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any)).thenReturn(null);
        // act
        final result = dataSourceImpl.getLastNumberTrivia;
        // assert
        expect(() => result(), throwsA(TypeMatcher<CacheException>()));
      },
    );
  });

  group('cacheNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel(number: 2, text: 'test cached');

    test(
      'should call sharedpreference to cache the data',
      () async {
        // act
        dataSourceImpl.cacheNumberTrivia(tNumberTriviaModel);
        // assert
        final expectedJsonString = json.encode(tNumberTriviaModel.toJson());
        verify(mockSharedPreferences.setString(
            CACHED_NUMBER_KEY, expectedJsonString));
      },
    );
  });
}
