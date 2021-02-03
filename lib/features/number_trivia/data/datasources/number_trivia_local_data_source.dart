import 'dart:convert';

import 'package:routing/core/errors/exceptions.dart';
import 'package:routing/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel);
}

const CACHED_NUMBER_KEY = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences sharedPreferences;

  NumberTriviaLocalDataSourceImpl({
    @required this.sharedPreferences,
  });

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_KEY);
    // because sharedpref is syncrhonous but we want to return Future (async) so
    // musut return with Future.value
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheNumberTrivia(NumberTriviaModel triviaModel) {
    return sharedPreferences.setString(
      CACHED_NUMBER_KEY,
      json.encode(triviaModel.toJson()),
    );
  }
}
