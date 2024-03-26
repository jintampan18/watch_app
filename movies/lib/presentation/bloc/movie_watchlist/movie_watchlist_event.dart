part of 'movie_watchlist_bloc.dart';

sealed class MovieWatchlistEvent extends Equatable {
  const MovieWatchlistEvent();

  @override
  List<Object> get props => [];
}

class MovieWathclistGetEvent extends MovieWatchlistEvent {}

class MovieWatchlistAddEvent extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const MovieWatchlistAddEvent({
    required this.movieDetail,
  });

  @override
  List<Object> get props => [movieDetail];
}

class MovieWatchlistRemoveEvent extends MovieWatchlistEvent {
  final MovieDetail movieDetail;

  const MovieWatchlistRemoveEvent({
    required this.movieDetail,
  });

  @override
  List<Object> get props => [movieDetail];
}
