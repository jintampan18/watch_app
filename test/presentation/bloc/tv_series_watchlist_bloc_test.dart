import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetWatchlistTvSeries,
  SaveTvSeriesWatchlist,
  RemoveTvSeriesWatchlist,
])
void main() {
  late TvSeriesWatchlistBloc tvSeriesWatchlistBloc;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late MockSaveTvSeriesWatchlist mockSaveTvSeriesWatchlist;
  late MockRemoveTvSeriesWatchlist mockRemoveTvSeriesWatchlist;

  setUp(() {
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    mockSaveTvSeriesWatchlist = MockSaveTvSeriesWatchlist();
    mockRemoveTvSeriesWatchlist = MockRemoveTvSeriesWatchlist();
    tvSeriesWatchlistBloc = TvSeriesWatchlistBloc(
      mockGetWatchlistTvSeries,
      mockRemoveTvSeriesWatchlist,
      mockSaveTvSeriesWatchlist,
    );
  });

  group(
    "Get TV Series Watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Loaded] when responded successfully",
        build: () {
          when(
            mockGetWatchlistTvSeries.execute(),
          ).thenAnswer((_) async => Right(testTvSeriesList));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistGetEvent()),
        expect: () => [
          TvSeriesWatchlistLoading(),
          TvSeriesWatchlistLoaded(tvSeries: testTvSeriesList),
        ],
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockGetWatchlistTvSeries.execute(),
          ).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) =>
            bloc.add(TvSeriesWatchlistGetEvent()),
        expect: () => [
          TvSeriesWatchlistLoading(),
          const TvSeriesWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );

  group(
    "Save TV Series Watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "should emit [Loading, Loaded] when responded successfully",
        build: () {
          when(
            mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer((_) async => const Right('Added to Watchlist'));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) => bloc.add(
            const TvSeriesWatchlistAddEvent(
                tvSeriesDetail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          const TvSeriesWatchlistAddSuccess(message: 'Added to Watchlist'),
        ],
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockSaveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) => bloc.add(
            const TvSeriesWatchlistAddEvent(
                tvSeriesDetail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          const TvSeriesWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );

  group(
    "Remove TV Series Watchlist",
    () {
      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Loaded] when responded successfully",
        build: () {
          when(
            mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer((_) async => const Right('Removed from Watchlist'));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) => bloc.add(
            const TvSeriesWatchlistRemoveEvent(
                tvSeriesDetail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          const TvSeriesWatchlistAddSuccess(message: 'Removed from Watchlist'),
        ],
      );

      blocTest<TvSeriesWatchlistBloc, TvSeriesWatchlistState>(
        "testing emit [Loading, Error] when responded unsuccessful",
        build: () {
          when(
            mockRemoveTvSeriesWatchlist.execute(testTvSeriesDetail),
          ).thenAnswer(
              (_) async => const Left(ServerFailure('Server Failure')));

          return tvSeriesWatchlistBloc;
        },
        act: (TvSeriesWatchlistBloc bloc) => bloc.add(
            const TvSeriesWatchlistRemoveEvent(
                tvSeriesDetail: testTvSeriesDetail)),
        expect: () => [
          TvSeriesWatchlistLoading(),
          const TvSeriesWatchlistError(message: 'Server Failure'),
        ],
      );
    },
  );
}
