import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_top_rated_event.dart';
part 'tv_series_top_rated_state.dart';

class TvSeriesTopRatedBloc
    extends Bloc<TvSeriesTopRatedEvent, TvSeriesTopRatedState> {
  final GetTopRatedTvSeries usecases;

  TvSeriesTopRatedBloc(this.usecases) : super(TvSeriesTopRatedInitial()) {
    on<TvSeriesTopRatedGetEvent>((event, emit) async {
      emit(TvSeriesTopRatedLoading());
      final result = await usecases.execute();
      result.fold(
        (l) => emit(TvSeriesTopRatedError(message: l.message)),
        (r) => emit(TvSeriesTopRatedLoaded(tvSeries: r)),
      );
    });
  }
}
