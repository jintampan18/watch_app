part of 'tv_series_watchlist_bloc.dart';

sealed class TvSeriesWatchlistEvent extends Equatable {
  const TvSeriesWatchlistEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesWatchlistGetEvent extends TvSeriesWatchlistEvent {}

class TvSeriesWatchlistAddEvent extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  const TvSeriesWatchlistAddEvent({
    required this.tvSeriesDetail,
  });

  @override
  List<Object> get props => [tvSeriesDetail];
}

class TvSeriesWatchlistRemoveEvent extends TvSeriesWatchlistEvent {
  final TvSeriesDetail tvSeriesDetail;

  const TvSeriesWatchlistRemoveEvent({
    required this.tvSeriesDetail,
  });

  @override
  List<Object> get props => [tvSeriesDetail];
}
