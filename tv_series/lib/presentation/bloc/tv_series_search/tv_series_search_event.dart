part of 'tv_series_search_bloc.dart';

sealed class TvSeriesSearchEvent extends Equatable {
  const TvSeriesSearchEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesSearchQueryEvent extends TvSeriesSearchEvent {
  final String query;

  const TvSeriesSearchQueryEvent(
    this.query,
  );

  @override
  List<Object> get props => [query];
}
