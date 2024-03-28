part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailGetEvent extends MovieDetailEvent {
  final int id;

  const MovieDetailGetEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class AddWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveFromWatchlistMovie extends MovieDetailEvent {
  final MovieDetail movieDetail;

  const RemoveFromWatchlistMovie(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class LoadWatchlistStatusMovie extends MovieDetailEvent {
  final int id;

  const LoadWatchlistStatusMovie(this.id);

  @override
  List<Object> get props => [id];
}
