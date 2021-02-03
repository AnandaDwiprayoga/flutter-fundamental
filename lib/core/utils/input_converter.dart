import 'package:dartz/dartz.dart';
import 'package:routing/core/errors/failure.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInt(String str) {
    try {
      final int result = int.parse(str);
      // make jump to on FormatException bellow when the int is negative
      if (result < 0) throw FormatException();
      return Right(result);
    } on FormatException {
      return Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {}
