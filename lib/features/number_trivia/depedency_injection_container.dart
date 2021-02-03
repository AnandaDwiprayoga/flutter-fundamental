import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:routing/core/network/network_info.dart';
import 'package:routing/core/utils/input_converter.dart';
import 'package:routing/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:routing/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:routing/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:routing/features/number_trivia/domain/usecases/get_concrate_number_trivia.dart';
import 'package:routing/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:routing/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/number_trivia_remote_data_source.dart';

final getInstance = GetIt.instance;

Future<void> init() async {
  // registerFactory create new instance every called,
  // because bloc is stream we need to create factory so when the stream closed is not effect the whole bloc
  getInstance.registerFactory(
    () => NumberTriviaBloc(
        // getInstance() too find module that have been inject
        getRandomNumberTrivia: getInstance(),
        getConcrateNumberTrivia: getInstance(),
        inputConverter: getInstance()),
  );

// singleton mean just return one instance when called
// lazy mean just register when the instance called
  getInstance.registerLazySingleton(
    () => GetConcrateNumberTrivia(getInstance()),
  );

  getInstance.registerLazySingleton(() => GetRandomNumberTrivia(getInstance()));

  getInstance.registerLazySingleton(() => InputConverter());

  // repository
  getInstance.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
        localDataSource: getInstance(),
        remoteDataSource: getInstance(),
        networkInfo: getInstance()),
  );

  getInstance.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(sharedPreferences: getInstance()),
  );

  getInstance.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(client: getInstance()),
  );

  getInstance.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(getInstance()),
  );

  final sharedPref = await SharedPreferences.getInstance();
  getInstance.registerLazySingleton(() => sharedPref);
  getInstance.registerLazySingleton(() => http.Client());
  getInstance.registerLazySingleton(() => DataConnectionChecker());
}
