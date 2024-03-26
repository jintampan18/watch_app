import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListMovies;

  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
    this.getWatchListMovies,
  ) : super(MovieDetailInitial()) {
    on<MovieDetailGetEvent>((event, emit) async {
      emit(MovieDetailLoading());

      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);
      final isWatchlist = await getWatchListMovies.execute(event.id);

      detailResult.fold(
        (l) async => emit(MovieDetailError(message: l.message)),
        (detail) async => recommendationResult.fold(
          (l) async => emit(MovieDetailError(message: l.message)),
          (recommendations) async => emit(MovieDetailLoaded(
            detail: detail,
            recommendations: recommendations,
            isWatchlist: isWatchlist,
          )),
        ),
      );
    });
  }
}
