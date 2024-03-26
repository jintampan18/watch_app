part of 'movie_now_playing_bloc.dart';

sealed class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();

  @override
  List<Object> get props => [];
}

final class MovieNowPlayingInitial extends MovieNowPlayingState {}

final class MovieNowPlayingLoading extends MovieNowPlayingState {}

final class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class MovieNowPlayingLoaded extends MovieNowPlayingState {
  final List<Movie> movies;

  const MovieNowPlayingLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
