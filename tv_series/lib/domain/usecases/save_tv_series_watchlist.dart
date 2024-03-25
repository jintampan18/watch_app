import '../entities/tv_series_detail.dart';
import '../repositories/tv_series_repository.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';

class SaveTvSeriesWatchlist {
  final TvSeriesRepository repository;

  SaveTvSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.saveTvSeriesWatchlist(tvSeries);
  }
}
