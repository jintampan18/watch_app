import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/movies.dart';
import 'package:mockito/mockito.dart';

import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchListStatus,
    );
  });

  const tId = 1;

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
  final tMovies = <Movie>[tMovie];

  const testMovieDetail = MovieDetail(
    adult: false,
    backdropPath: 'backdropPath',
    genres: [GenreMovies(id: 1, name: 'Action')],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    runtime: 120,
    title: 'title',
    voteAverage: 1,
    voteCount: 1,
  );

  group('test movie detail bloc', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      "Test get detail by id emit [Loading, Loaded] when Movie Detail response is successfully",
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => const Right(testMovieDetail));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tMovies));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => true);

        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(const MovieDetailGetEvent(id: tId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailLoaded(
          detail: testMovieDetail,
          recommendations: tMovies,
          isWatchlist: true,
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "Test get detail emit [Loading, Error] when Get Movie Detail response is unsuccessful",
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => Right(tMovies));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => true);

        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(const MovieDetailGetEvent(id: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailError(
          message: 'Server Failure',
        ),
      ],
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      "test get detail emit [Loading, Error] when Movie Recommendations response is unsuccessful",
      build: () {
        when(
          mockGetMovieDetail.execute(tId),
        ).thenAnswer((_) async => const Right(testMovieDetail));
        when(
          mockGetMovieRecommendations.execute(tId),
        ).thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        when(
          mockGetWatchListStatus.execute(tId),
        ).thenAnswer((_) async => true);

        return movieDetailBloc;
      },
      act: (MovieDetailBloc bloc) =>
          bloc.add(const MovieDetailGetEvent(id: tId)),
      expect: () => [
        MovieDetailLoading(),
        const MovieDetailError(message: 'Server Failure'),
      ],
    );
  });
}
