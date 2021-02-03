import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:routing/core/errors/failure.dart';
import 'package:routing/core/utils/input_converter.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:routing/features/number_trivia/domain/usecases/get_concrate_number_trivia.dart';
import 'package:routing/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The Number must be a positive or zero';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcrateNumberTrivia getConcrateNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    @required this.getRandomNumberTrivia,
    @required this.getConcrateNumberTrivia,
    @required this.inputConverter,
  }) : super(Empty());

  @override
  Stream<NumberTriviaState> mapEventToState(
    NumberTriviaEvent event,
  ) async* {
    if (event is GetTriviaForConcrateNumber) {
      final inputEither =
          inputConverter.stringToUnsignedInt(event.numberString);

      // fold is the power of either type, so can return left or right condition
      // yield return async stream, yield* mean iterable
      yield* inputEither.fold(
        (failure) async* {
          yield Error(message: INVALID_INPUT_FAILURE_MESSAGE);
        },
        (integer) async* {
          yield Loading();

          final getConcrateResult =
              await getConcrateNumberTrivia(Params(integer));

          yield* _eitherLoadedOrErrorState(getConcrateResult);
        },
      );
    } else if (event is GetTriviaForRandomNumber) {
      yield Loading();

      final getRandomResult = await getRandomNumberTrivia(NoParams());

      yield* _eitherLoadedOrErrorState(getRandomResult);
    }
  }

  Stream<NumberTriviaState> _eitherLoadedOrErrorState(
    Either<Failure, NumberTrivia> getConcrateResult,
  ) async* {
    yield getConcrateResult.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (numberTrivia) => Loaded(trivia: numberTrivia),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
