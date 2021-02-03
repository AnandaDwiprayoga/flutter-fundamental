import 'package:equatable/equatable.dart';
import 'package:routing/core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:routing/core/usecases/use_case.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:routing/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia implements UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository repository;

  GetRandomNumberTrivia(this.repository);

  @override
  Future<Either<Failure, NumberTrivia>> call(NoParams params) async {
    return await repository.getRandomNumberTrivia();
  }
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
