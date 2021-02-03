import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:routing/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:routing/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:routing/features/number_trivia/domain/usecases/get_concrate_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcrateNumberTrivia usecase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcrateNumberTrivia(mockNumberTriviaRepository);
  });

  final tNumber = 1;
  final tNumberTrivia = NumberTrivia(text: 'test', number: 1);

  test(
    'should get trivia for the number from repository',
    () async {
      // arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          //coz getConcrateNumberTrivia return type Either<Left (failure), Right (success)>
          // so in this test wi will return Right type (sucess)
          .thenAnswer((_) async => Right(tNumberTrivia));
      // act
      final result = await usecase(Params(tNumber));
      // assert
      expect(result, Right(tNumberTrivia));
      // verify that paramer pass with same in execute fungction
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}
