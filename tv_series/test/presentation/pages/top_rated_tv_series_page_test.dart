import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSeriesTopRatedBloc
    extends MockBloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState>
    implements TvSeriesTopRatedBloc {}

class FakeTvSeriesTopRatedEvent extends Fake implements TvSeriesTopRatedEvent {}

class FakeTvSeriesTopRatedState extends Fake implements TvSeriesTopRatedState {}

void main() {
  late MockTvSeriesTopRatedBloc mockTvSeriesopRatedBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvSeriesTopRatedEvent());
    registerFallbackValue(FakeTvSeriesTopRatedState());
  });

  setUp(() {
    mockTvSeriesopRatedBloc = MockTvSeriesTopRatedBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeriesTopRatedBloc>.value(
      value: mockTvSeriesopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTvSeriesopRatedBloc.state)
        .thenReturn(TvSeriesTopRatedLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTvSeriesopRatedBloc.state)
        .thenReturn(TvSeriesTopRatedLoaded(tvSeries: [testTvSeries]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTvSeriesopRatedBloc.state)
        .thenReturn(const TvSeriesTopRatedError(message: 'Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvSeriesPage()));

    expect(textFinder, findsOneWidget);
  });
}
