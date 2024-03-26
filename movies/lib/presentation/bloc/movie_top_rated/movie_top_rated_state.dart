part of 'movie_top_rated_bloc.dart';

sealed class MovieTopRatedState extends Equatable {
  const MovieTopRatedState();

  @override
  List<Object> get props => [];
}

final class MovieTopRatedInitial extends MovieTopRatedState {}

final class MovieTopRatedLoading extends MovieTopRatedState {}

final class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  const MovieTopRatedError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class MovieTopRatedLoaded extends MovieTopRatedState {
  final List<Movie> movies;

  const MovieTopRatedLoaded({
    required this.movies,
  });

  @override
  List<Object> get props => [movies];
}
