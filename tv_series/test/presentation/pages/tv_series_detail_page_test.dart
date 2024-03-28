import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesDetailBloc
    extends MockBloc<TvSeriesDetailEvent, TvSeriesDetailState>
    implements TvSeriesDetailBloc {}

class FakeTvSeriesDetailEvent extends Fake implements TvSeriesDetailEvent {}

class FakeTvSeriesDetailState extends Fake implements TvSeriesDetailState {}

class MockWatchlistStatusTvSeriesBloc
    extends MockBloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState>
    implements TvSeriesWatchlistBloc {}

class FakeWatchlistStatusTvSeriesEvent extends Fake
    implements TvSeriesWatchlistEvent {}

class FakeWatchlistStatusTvSeriesState extends Fake
    implements TvSeriesWatchlistState {}

void main() {
  late MockTvSeriesDetailBloc mockDetailTvSeriesBloc;
  late MockWatchlistStatusTvSeriesBloc mockWatchlistStatusTvSeriesBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvSeriesDetailEvent());
    registerFallbackValue(FakeTvSeriesDetailState());
    registerFallbackValue(FakeWatchlistStatusTvSeriesEvent());
    registerFallbackValue(FakeWatchlistStatusTvSeriesState());
  });

  setUp(() {
    mockDetailTvSeriesBloc = MockTvSeriesDetailBloc();
    mockWatchlistStatusTvSeriesBloc = MockWatchlistStatusTvSeriesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvSeriesDetailBloc>.value(value: mockDetailTvSeriesBloc),
        BlocProvider<TvSeriesWatchlistBloc>.value(
          value: mockWatchlistStatusTvSeriesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;

  testWidgets(
      'Watchlist button should display add icon when tv series not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state).thenReturn(
      TvSeriesDetailLoaded(
        detail: testTvSeriesDetail,
        recommendations: [testTvSeries],
        isWatchlist: false,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when tv series is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockDetailTvSeriesBloc.state).thenReturn(
      TvSeriesDetailLoaded(
        detail: testTvSeriesDetail,
        recommendations: [testTvSeries],
        isWatchlist: true,
      ),
    );

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester
        .pumpWidget(makeTestableWidget(const TvSeriesDetailPage(id: tId)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
