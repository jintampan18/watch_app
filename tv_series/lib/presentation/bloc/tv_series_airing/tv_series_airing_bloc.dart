import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_airing_event.dart';
part 'tv_series_airing_state.dart';

class TvSeriesAiringBloc
    extends Bloc<TvSeriesAiringEvent, TvSeriesAiringState> {
  final GetAiringTvSeries usecases;

  TvSeriesAiringBloc(this.usecases) : super(TvSeriesAiringInitial()) {
    on<TvSeriesAiringGetEvent>((event, emit) async {
      emit(TvSeriesAiringLoading());
      final result = await usecases.execute();
      result.fold(
        (l) => emit(TvSeriesAiringError(message: l.message)),
        (r) => emit(TvSeriesAiringLoaded(tvSeries: r)),
      );
    });
  }
}
