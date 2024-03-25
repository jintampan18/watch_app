import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_series.dart';
import '../../domain/usecases/get_watchlist_tv_series.dart';

class WatchlistTvSeriesNotifier extends ChangeNotifier {
  var _watchlistTvSeries = <TvSeries>[];
  List<TvSeries> get watchlistTvSeries => _watchlistTvSeries;

  var _watchlistTvSeriesState = RequestState.Empty;
  RequestState get watchlistTvSeriesState => _watchlistTvSeriesState;

  String _message = '';
  String get message => _message;

  WatchlistTvSeriesNotifier({required this.getWatchlistTvSeries});

  final GetWatchlistTvSeries getWatchlistTvSeries;

  Future<void> fetchWatchlistTvSeries() async {
    _watchlistTvSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlistTvSeries.execute();
    result.fold(
      (failure) {
        _watchlistTvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _watchlistTvSeriesState = RequestState.Loaded;
        _watchlistTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
