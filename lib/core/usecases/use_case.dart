import 'package:dartz/dartz.dart';
import 'package:routing/core/errors/failure.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, NumberTrivia>> call(Params params);
}
