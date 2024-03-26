part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {
  final String message;

  const MovieDetailError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail detail;
  final List<Movie> recommendations;
  final bool isWatchlist;

  const MovieDetailLoaded({
    required this.detail,
    required this.recommendations,
    required this.isWatchlist,
  });

  @override
  List<Object> get props => [detail, recommendations, isWatchlist];
}
