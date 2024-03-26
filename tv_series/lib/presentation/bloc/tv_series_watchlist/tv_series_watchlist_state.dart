part of 'tv_series_watchlist_bloc.dart';

sealed class TvSeriesWatchlistState extends Equatable {
  const TvSeriesWatchlistState();

  @override
  List<Object> get props => [];
}

final class TvSeriesWatchlistInitial extends TvSeriesWatchlistState {}

final class TvSeriesWatchlistLoading extends TvSeriesWatchlistState {}

final class TvSeriesWatchlistError extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class TvSeriesWatchlistAddSuccess extends TvSeriesWatchlistState {
  final String message;

  const TvSeriesWatchlistAddSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class TvSeriesWatchlistLoaded extends TvSeriesWatchlistState {
  final List<TvSeries> tvSeries;

  const TvSeriesWatchlistLoaded({
    required this.tvSeries,
  });

  @override
  List<Object> get props => [tvSeries];
}
