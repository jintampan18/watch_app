import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'movie_popular_bloc_test.mocks.dart';

@GenerateMocks([
  GetPopularMovies,
])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  blocTest<MoviePopularBloc, MoviePopularState>(
    "Testing movie populier emit [Loading, Loaded] when Get Popular Movie response is successfully",
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => Right(tMovieList));
      return moviePopularBloc;
    },
    act: (MoviePopularBloc bloc) => bloc.add(MoviePopularGetEvent()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularLoaded(movies: tMovieList),
    ],
  );

  blocTest<MoviePopularBloc, MoviePopularState>(
    "Testing movie popular emit [Loading, Error] when Get Popular Movie response is unsuccessful",
    build: () {
      when(
        mockGetPopularMovies.execute(),
      ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

      return moviePopularBloc;
    },
    act: (MoviePopularBloc bloc) => bloc.add(MoviePopularGetEvent()),
    expect: () => [
      MoviePopularLoading(),
      const MoviePopularError(message: 'Server Failure'),
    ],
  );
}
