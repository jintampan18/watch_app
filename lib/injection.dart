import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:get_it/get_it.dart';

import 'package:core/core.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

final locator = GetIt.instance;

void init() async {
  // Bloc Movie
  locator.registerFactory(
    () => MovieNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () =>
        MovieDetailBloc(locator(), locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  // Bloc Tv-Series
  locator.registerFactory(
    () => TvSeriesAiringBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesSearchBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesDetailBloc(
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesWatchlistBloc(
      locator(),
      locator(),
      locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv-series
  locator.registerLazySingleton(() => GetAiringTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesWatchListStatus(locator()));
  locator.registerLazySingleton(() => RemoveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => SaveTvSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
      () => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesLocalDataSource>(
      () => TvSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  // locator.registerLazySingleton(() => SSLPinning.client);
  HttpClient client = HttpClient(context: await globalContext);
  client.badCertificateCallback = (cert, host, port) => false;
  IOClient ioClient = IOClient(client);
  locator.registerLazySingleton<http.Client>(() => ioClient);
}
