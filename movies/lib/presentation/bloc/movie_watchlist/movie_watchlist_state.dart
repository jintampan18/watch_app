part of 'movie_watchlist_bloc.dart';

sealed class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object> get props => [];
}

final class MovieWatchlistInitial extends MovieWatchlistState {}

final class MovieWatchlistLoading extends MovieWatchlistState {}

final class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class MovieWatchlistAddSuccess extends MovieWatchlistState {
  final String message;

  const MovieWatchlistAddSuccess({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class MovieWatchlistLoaded extends MovieWatchlistState {
  final List<Movie> movies;

  const MovieWatchlistLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
