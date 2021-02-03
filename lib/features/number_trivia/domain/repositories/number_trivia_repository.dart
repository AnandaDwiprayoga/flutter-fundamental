import 'package:dartz/dartz.dart';
import 'package:routing/core/errors/failure.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  // type either make function return the left type or right type
  Future<Either<Failure, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failure, NumberTrivia>> getRandomNumberTrivia();
}
