part of 'tv_series_search_bloc.dart';

sealed class TvSeriesSearchState extends Equatable {
  const TvSeriesSearchState();

  @override
  List<Object> get props => [];
}

final class TvSeriesSearchInitial extends TvSeriesSearchState {}

class TvSeriesSearchLoading extends TvSeriesSearchState {}

class TvSeriesSearchError extends TvSeriesSearchState {
  final String message;

  const TvSeriesSearchError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class TvSeriesSearchLoaded extends TvSeriesSearchState {
  final List<TvSeries> result;

  const TvSeriesSearchLoaded({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
