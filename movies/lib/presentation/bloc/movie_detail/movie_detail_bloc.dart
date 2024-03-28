import 'package:core/utils/state_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final SaveWatchlist saveWatchListMovie;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchlistStatus;

  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.saveWatchListMovie,
    this.removeWatchlist,
    this.getWatchlistStatus,
  ) : super(MovieDetailState.initial()) {
    on<MovieDetailGetEvent>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.loading));

      final id = event.id;

      final detailMovieResult = await getMovieDetail.execute(id);
      final recommendationMoviesResult =
          await getMovieRecommendations.execute(id);

      detailMovieResult.fold(
        (failure) => emit(
          state.copyWith(
            movieDetailState: RequestState.error,
            message: failure.message,
          ),
        ),
        (movieDetail) {
          emit(
            state.copyWith(
              movieRecommendationsState: RequestState.loading,
              movieDetailState: RequestState.loaded,
              movieDetail: movieDetail,
            ),
          );
          recommendationMoviesResult.fold(
            (failure) => emit(
              state.copyWith(
                movieRecommendationsState: RequestState.error,
                message: failure.message,
              ),
            ),
            (movieRecommendations) {
              if (movieRecommendations.isEmpty) {
                emit(
                  state.copyWith(
                    movieRecommendationsState: RequestState.empty,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    movieRecommendationsState: RequestState.loaded,
                    movieRecommendations: movieRecommendations,
                  ),
                );
              }
            },
          );
        },
      );
    });

    on<AddWatchlistMovie>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await saveWatchListMovie.execute(movieDetail);

      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(watchlistMessage: successMessage)),
      );

      add(LoadWatchlistStatusMovie(movieDetail.id));
    });

    on<RemoveFromWatchlistMovie>((event, emit) async {
      final movieDetail = event.movieDetail;
      final result = await removeWatchlist.execute(movieDetail);

      result.fold(
        (failure) => emit(state.copyWith(watchlistMessage: failure.message)),
        (successMessage) =>
            emit(state.copyWith(watchlistMessage: successMessage)),
      );

      add(LoadWatchlistStatusMovie(movieDetail.id));
    });

    on<LoadWatchlistStatusMovie>((event, emit) async {
      final status = await getWatchlistStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: status));
    });
  }
}
