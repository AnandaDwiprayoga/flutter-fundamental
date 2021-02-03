import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:routing/core/usecases/use_case.dart';
import 'package:routing/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:routing/core/errors/failure.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';

class GetConcrateNumberTrivia implements UseCase<NumberTrivia, Params> {
  final NumberTriviaRepository repository;

  GetConcrateNumberTrivia(this.repository);

// this method call automated call when class instance
  @override
  Future<Either<Failure, NumberTrivia>> call(Params params) async {
    return await repository.getConcreteNumberTrivia(params.number);
  }
}

class Params extends Equatable {
  final int number;

  Params(this.number);

  @override
  List<Object> get props => [number];
}
