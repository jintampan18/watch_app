library tv_series;

// entities
export 'domain/entities/genre.dart';
export 'domain/entities/tv_series.dart';
export 'domain/entities/tv_series_detail.dart';

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

// bloc
export 'presentation/bloc/tv_series_airing/tv_series_airing_bloc.dart';
export 'presentation/bloc/tv_series_detail/tv_series_detail_bloc.dart';
export 'presentation/bloc/tv_series_popular/tv_series_popular_bloc.dart';
export 'presentation/bloc/tv_series_search/tv_series_search_bloc.dart';
export 'presentation/bloc/tv_series_top_rated/tv_series_top_rated_bloc.dart';
export 'presentation/bloc/tv_series_watchlist/tv_series_watchlist_bloc.dart';

// pages
export 'presentation/pages/popular_tv_series_page.dart';
export 'presentation/pages/search_tv_series_page.dart';
export 'presentation/pages/top_rated_tv_series_page.dart';
export 'presentation/pages/tv_series_detail_page.dart';
export 'presentation/pages/tv_series_page.dart';
export 'presentation/pages/watchlist_tv_series_page.dart';
