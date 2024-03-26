part of 'tv_series_detail_bloc.dart';

sealed class TvSeriesDetailEvent extends Equatable {
  const TvSeriesDetailEvent();

  @override
  List<Object> get props => [];
}

class TvSeriesDetailGetEvent extends TvSeriesDetailEvent {
  final int id;

  const TvSeriesDetailGetEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
