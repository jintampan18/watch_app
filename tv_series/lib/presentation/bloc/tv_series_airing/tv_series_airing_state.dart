part of 'tv_series_airing_bloc.dart';

sealed class TvSeriesAiringState extends Equatable {
  const TvSeriesAiringState();

  @override
  List<Object> get props => [];
}

final class TvSeriesAiringInitial extends TvSeriesAiringState {}

final class TvSeriesAiringLoading extends TvSeriesAiringState {}

final class TvSeriesAiringError extends TvSeriesAiringState {
  final String message;

  const TvSeriesAiringError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class TvSeriesAiringLoaded extends TvSeriesAiringState {
  final List<TvSeries> tvSeries;

  const TvSeriesAiringLoaded({
    required this.tvSeries,
  });

  @override
  List<Object> get props => [tvSeries];
}
