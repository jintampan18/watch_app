library movies;

// entities
export 'domain/entities/genre.dart';
export 'domain/entities/movie.dart';
export 'domain/entities/movie_detail.dart';

// datasources
export 'data/datasources/movie_remote_data_source.dart';
export 'data/datasources/movie_local_data_source.dart';

// repository
export 'data/repositories/movie_repository_impl.dart';
export 'domain/repositories/movie_repository.dart';

// usecases
export 'domain/usecases/get_movie_detail.dart';
export 'domain/usecases/get_movie_recommendations.dart';
export 'domain/usecases/get_now_playing_movies.dart';
export 'domain/usecases/get_popular_movies.dart';
export 'domain/usecases/get_top_rated_movies.dart';
export 'domain/usecases/get_watchlist_movies.dart';
export 'domain/usecases/get_watchlist_status.dart';
export 'domain/usecases/remove_watchlist.dart';
export 'domain/usecases/save_watchlist.dart';
export 'domain/usecases/search_movies.dart';

// provider
export 'presentation/provider/movie_detail_notifier.dart';
export 'presentation/provider/movie_list_notifier.dart';
export 'presentation/provider/movie_search_notifier.dart';
export 'presentation/provider/popular_movies_notifier.dart';
export 'presentation/provider/top_rated_movies_notifier.dart';
export 'presentation/provider/watchlist_movie_notifier.dart';

// bloc
export 'presentation/bloc/movie_detail/movie_detail_bloc.dart';
export 'presentation/bloc/movie_now_playing/movie_now_playing_bloc.dart';
export 'presentation/bloc/movie_popular/movie_popular_bloc.dart';
export 'presentation/bloc/movie_search/search_bloc.dart';
export 'presentation/bloc/movie_top_rated/movie_top_rated_bloc.dart';
export 'presentation/bloc/movie_watchlist/movie_watchlist_bloc.dart';

// pages
export 'presentation/pages/home_movie_page.dart';
export 'presentation/pages/movie_detail_page.dart';
export 'presentation/pages/popular_movies_page.dart';
export 'presentation/pages/search_page.dart';
export 'presentation/pages/top_rated_movies_page.dart';
export 'presentation/pages/watchlist_movies_page.dart';
