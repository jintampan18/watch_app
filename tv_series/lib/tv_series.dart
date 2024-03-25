library tv_series;

// datasources
export 'data/datasources/tv_series_local_data_source.dart';
export 'data/datasources/tv_series_remote_data_source.dart';

// repository
export 'data/repositories/tv_series_repository_impl.dart';
export 'domain/repositories/tv_series_repository.dart';

// usecases
export 'domain/usecases/get_airing_tv_series.dart';
export 'domain/usecases/get_popular_tv_series.dart';
export 'domain/usecases/get_top_rated_tv_series.dart';
export 'domain/usecases/get_tv_series_detail.dart';
export 'domain/usecases/get_tv_series_recommendations.dart';
export 'domain/usecases/get_tv_series_watchlist_status.dart';
export 'domain/usecases/get_watchlist_tv_series.dart';
export 'domain/usecases/remove_tv_series_watchlist.dart';
export 'domain/usecases/save_tv_series_watchlist.dart';
export 'domain/usecases/search_tv_series.dart';

// provider
export 'presentation/provider/popular_tv_series_notifier.dart';
export 'presentation/provider/top_rated_tv_series_notifier.dart';
export 'presentation/provider/tv_series_detail_notifier.dart';
export 'presentation/provider/tv_series_list_notifier.dart';
export 'presentation/provider/tv_series_search_notifier.dart';
export 'presentation/provider/watchlist_tv_series_notifier.dart';

// pages
export 'presentation/pages/popular_tv_series_page.dart';
export 'presentation/pages/search_tv_series_page.dart';
export 'presentation/pages/top_rated_tv_series_page.dart';
export 'presentation/pages/tv_series_detail_page.dart';
export 'presentation/pages/tv_series_page.dart';
export 'presentation/pages/watchlist_tv_series_page.dart';
