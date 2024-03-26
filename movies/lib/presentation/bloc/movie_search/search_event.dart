part of 'search_bloc.dart';

sealed class MovieSearchEvent extends Equatable {
  const MovieSearchEvent();

  @override
  List<Object> get props => [];
}

class MovieSearchQueryEvent extends MovieSearchEvent {
  final String query;

  const MovieSearchQueryEvent(
    this.query,
  );

  @override
  List<Object> get props => [query];
}
