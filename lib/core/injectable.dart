import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movie_trailer/core/local_datasource.dart';
import 'package:flutter_movie_trailer/store/details_store.dart';
import 'package:flutter_movie_trailer/store/home_store.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import 'api.dart';

Future<void> setup() async {
  final GetIt getIt = GetIt.instance;

  await DotEnv().load('.env');
  final dio = Dio();
  dio.options.baseUrl = 'https://api.themoviedb.org/3';
  dio.options.queryParameters = <String, dynamic>{
    'api_key': DotEnv().env['TMDB_KEY'],
    'language': 'en-US',
  };

  getIt.registerSingleton<API>(API(dio));
  getIt.registerSingleton<LocalDatasource>(LocalDatasource());

  getIt.registerFactory<HomeStore>(
    () => HomeStore(
      api: getIt<API>(),
      localDatasource: getIt<LocalDatasource>(),
    ),
  );

  getIt.registerFactoryParam<DetailsStore, int, void>(
    (movieId, _) => DetailsStore(
      movieId: movieId,
      api: getIt<API>(),
      localDatasource: getIt<LocalDatasource>(),
    ),
  );
}
