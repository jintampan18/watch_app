import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_search_event.dart';
part 'tv_series_search_state.dart';

class TvSeriesSearchBloc
    extends Bloc<TvSeriesSearchEvent, TvSeriesSearchState> {
  final SearchTvSeries usecases;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  TvSeriesSearchBloc(this.usecases) : super(TvSeriesSearchInitial()) {
    on<TvSeriesSearchQueryEvent>((event, emit) async {
      final query = event.query;

      emit(TvSeriesSearchLoading());
      final result = await usecases.execute(query);

      result.fold(
        (l) => emit(TvSeriesSearchError(message: l.message)),
        (r) => emit(TvSeriesSearchLoaded(result: r)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
