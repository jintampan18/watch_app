import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_popular_event.dart';
part 'tv_series_popular_state.dart';

class TvSeriesPopularBloc
    extends Bloc<TvSeriesPopularEvent, TvSeriesPopularState> {
  final GetPopularTvSeries usecases;

  TvSeriesPopularBloc(this.usecases) : super(TvSeriesPopularInitial()) {
    on<TvSeriesPopularGetEvent>((event, emit) async {
      emit(TvSeriesPopularLoading());
      final result = await usecases.execute();
      result.fold(
        (l) => emit(TvSeriesPopularError(message: l.message)),
        (r) => emit(TvSeriesPopularLoaded(tvSeries: r)),
      );
    });
  }
}
