part of 'search_bloc.dart';

sealed class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

final class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchError extends MovieSearchState {
  final String message;

  const MovieSearchError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> result;

  const MovieSearchLoaded({
    required this.result,
  });

  @override
  List<Object> get props => [result];
}
