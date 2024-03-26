import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/tv_series.dart';

part 'tv_series_watchlist_event.dart';
part 'tv_series_watchlist_state.dart';

class TvSeriesWatchlistBloc
    extends Bloc<TvSeriesWatchlistEvent, TvSeriesWatchlistState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final RemoveTvSeriesWatchlist removeTvSeriesWatchlist;
  final SaveTvSeriesWatchlist saveTvSeriesWatchlist;

  TvSeriesWatchlistBloc(
    this.getWatchlistTvSeries,
    this.removeTvSeriesWatchlist,
    this.saveTvSeriesWatchlist,
  ) : super(TvSeriesWatchlistInitial()) {
    on<TvSeriesWatchlistGetEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoading());
      final result = await getWatchlistTvSeries.execute();
      result.fold(
        (l) => emit(TvSeriesWatchlistError(message: l.message)),
        (r) => emit(TvSeriesWatchlistLoaded(tvSeries: r)),
      );
    });

    on<TvSeriesWatchlistAddEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoading());
      final result = await saveTvSeriesWatchlist.execute(event.tvSeriesDetail);
      result.fold(
        (l) => emit(TvSeriesWatchlistError(message: l.message)),
        (r) => emit(TvSeriesWatchlistAddSuccess(message: r)),
      );
    });

    on<TvSeriesWatchlistRemoveEvent>((event, emit) async {
      emit(TvSeriesWatchlistLoading());
      final result =
          await removeTvSeriesWatchlist.execute(event.tvSeriesDetail);
      result.fold(
        (l) => emit(TvSeriesWatchlistError(message: l.message)),
        (r) => emit(TvSeriesWatchlistAddSuccess(message: r)),
      );
    });
  }
}
