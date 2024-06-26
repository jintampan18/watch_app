import '../entities/tv_series.dart';
import '../repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedTvSeries {
  final TvSeriesRepository repository;

  GetTopRatedTvSeries(
    this.repository,
  );

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
