import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MovieNowPlayingBloc movieNowPlayingBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
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

  group('test movie now playing bloc', () {
    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      "test movie now playing emit [Loading, Loaded] when Get Now Playing Movie response is successfully",
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenAnswer((_) async => Right(tMovieList));

        return movieNowPlayingBloc;
      },
      act: (MovieNowPlayingBloc bloc) => bloc.add(MovieNowPlayingGetEvent()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingLoaded(movies: tMovieList),
      ],
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      "Testing movie now playing emit [Loading, Error] when Get Now Playing Movie response is unsuccessful",
      build: () {
        when(
          mockGetNowPlayingMovies.execute(),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));

        return movieNowPlayingBloc;
      },
      act: (MovieNowPlayingBloc bloc) => bloc.add(MovieNowPlayingGetEvent()),
      expect: () => [
        MovieNowPlayingLoading(),
        const MovieNowPlayingError(message: 'Server Failure'),
      ],
    );
  });
}
