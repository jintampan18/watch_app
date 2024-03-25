import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/tv_series.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetAiringTvSeries(mockTvSeriesRepository);
  });

  final tvSeries = <TvSeries>[];

  test('get list of TV Series airing from the repository', () async {
    // arrange
    when(mockTvSeriesRepository.getAiringTvSeries())
        .thenAnswer((_) async => Right(tvSeries));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tvSeries));
  });
}
