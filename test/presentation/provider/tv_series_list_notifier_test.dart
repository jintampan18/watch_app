import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/tv_series.dart';

import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetAiringTvSeries, GetPopularTvSeries, GetTopRatedTvSeries])
void main() {
  late TvSeriesListNotifier provider;
  late MockGetAiringTvSeries mockGetAiringTvSeries;
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late MockGetTopRatedTvSeries mockGetTopRatedTvSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAiringTvSeries = MockGetAiringTvSeries();
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    mockGetTopRatedTvSeries = MockGetTopRatedTvSeries();
    provider = TvSeriesListNotifier(
      getAiringTvSeries: mockGetAiringTvSeries,
      getPopularTvSeries: mockGetPopularTvSeries,
      getTopRatedTvSeries: mockGetTopRatedTvSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTvSeries = TvSeries(
    firstAirDate: '321',
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    name: 'fdsafds',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    originCountry: const ['id'],
    originalLanguage: 'id',
    originalName: 'turkturk,',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('now playing tv series', () {
    test('initialState should be Empty', () {
      expect(provider.airingTvSerieState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAiringTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchAiringTvSeries();
      // assert
      verify(mockGetAiringTvSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetAiringTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchAiringTvSeries();
      // assert
      expect(provider.airingTvSerieState, RequestState.Loading);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      when(mockGetAiringTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchAiringTvSeries();
      // assert
      expect(provider.airingTvSerieState, RequestState.Loaded);
      expect(provider.airingTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAiringTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAiringTvSeries();
      // assert
      expect(provider.airingTvSerieState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Loaded);
      expect(provider.popularTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvSeries();
      // assert
      expect(provider.popularTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loading);
    });

    test('should change tv series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Right(tTvSeriesList));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Loaded);
      expect(provider.topRatedTvSeries, tTvSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvSeries();
      // assert
      expect(provider.topRatedTvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
