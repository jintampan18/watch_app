part of 'tv_series_detail_bloc.dart';

abstract class TvSeriesDetailState extends Equatable {
  const TvSeriesDetailState();

  @override
  List<Object> get props => [];
}

final class TvSeriesDetailInitial extends TvSeriesDetailState {}

final class TvSeriesDetailLoading extends TvSeriesDetailState {}

final class TvSeriesDetailError extends TvSeriesDetailState {
  final String message;

  const TvSeriesDetailError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class TvSeriesDetailLoaded extends TvSeriesDetailState {
  final TvSeriesDetail detail;
  final List<TvSeries> recommendations;
  final bool isWatchlist;

  const TvSeriesDetailLoaded({
    required this.detail,
    required this.recommendations,
    required this.isWatchlist,
  });

  @override
  List<Object> get props => [detail, recommendations, isWatchlist];
}
