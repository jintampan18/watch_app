import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TvSeriesDetailBloc
    extends Bloc<TvSeriesDetailEvent, TvSeriesDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendations getTvSeriesRecommendations;
  final GetTvSeriesWatchListStatus getWatchListTvSeries;
  TvSeriesDetailBloc(
    this.getTvSeriesDetail,
    this.getTvSeriesRecommendations,
    this.getWatchListTvSeries,
  ) : super(TvSeriesDetailInitial()) {
    on<TvSeriesDetailGetEvent>((event, emit) async {
      emit(TvSeriesDetailLoading());

      final detailResult = await getTvSeriesDetail.execute(event.id);
      final recommendationResult =
          await getTvSeriesRecommendations.execute(event.id);
      final isWatchlist = await getWatchListTvSeries.execute(event.id);

      detailResult.fold(
        (l) async => emit(TvSeriesDetailError(message: l.message)),
        (detail) async => recommendationResult.fold(
          (l) async => emit(TvSeriesDetailError(message: l.message)),
          (recommendations) async => emit(TvSeriesDetailLoaded(
            detail: detail,
            recommendations: recommendations,
            isWatchlist: isWatchlist,
          )),
        ),
      );
    });
  }
}
