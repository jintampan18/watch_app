import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:movies/movies.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockSaveWatchlist,
      mockRemoveWatchlist,
      mockGetWatchListStatus,
    );
  });

  const tId = 1;

  group('Get Detail Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieLoading, DetailMovieLoaded, RecomendationLoading, RecommendationLoaded] when get detail movie and recommendation movies success',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailGetEvent(id: tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.loading,
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.loaded,
          movieRecommendations: testMovieList,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieError] when get detail movie failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailGetEvent(id: tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieLoading, DetailMovieLoaded, RecommendationEmpty] when get recommendation movies empty',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Right([]));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailGetEvent(id: tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.loading,
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.empty,
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [DetailMovieLoading, RecomendationLoading, DetailMovieLoaded, RecommendationError] when get recommendation movies failed',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => const Left(ConnectionFailure('Failed')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const MovieDetailGetEvent(id: tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.loading,
        ),
        MovieDetailState.initial().copyWith(
          movieRecommendationsState: RequestState.loading,
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
        ),
        MovieDetailState.initial().copyWith(
          movieDetailState: RequestState.loaded,
          movieDetail: testMovieDetail,
          movieRecommendationsState: RequestState.error,
          message: 'Failed',
        ),
      ],
      verify: (_) {
        verify(mockGetMovieDetail.execute(tId));
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Load Watchlist Status Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [WatchlistStatus] is true',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatusMovie(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(isAddedToWatchlist: true),
      ],
      verify: (_) => verify(mockGetWatchListStatus.execute(tId)),
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [WatchlistStatus] is false',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatusMovie(tId)),
      expect: () => [
        MovieDetailState.initial().copyWith(isAddedToWatchlist: false),
      ],
      verify: (_) => verify(mockGetWatchListStatus.execute(tId)),
    );
  });

  group('Added To Watchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
        ),
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Added to Watchlist',
          isAddedToWatchlist: true,
        ),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage] when failed added to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const AddWatchlistMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });

  group('Remove From Watchlist Movie', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage, isAddedToWatchlist] when success removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchlistMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(
          watchlistMessage: 'Removed from Watchlist',
          isAddedToWatchlist: false,
        ),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Shoud emit [WatchlistMessage] when failed removed from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const RemoveFromWatchlistMovie(testMovieDetail)),
      expect: () => [
        MovieDetailState.initial().copyWith(watchlistMessage: 'Failed'),
      ],
      verify: (_) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
        verify(mockGetWatchListStatus.execute(testMovieDetail.id));
      },
    );
  });
}
