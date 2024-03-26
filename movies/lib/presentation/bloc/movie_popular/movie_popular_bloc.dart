import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies usecases;

  MoviePopularBloc(this.usecases) : super(MoviePopularInitial()) {
    on<MoviePopularGetEvent>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await usecases.execute();
      result.fold(
        (l) => emit(MoviePopularError(message: l.message)),
        (r) => emit(MoviePopularLoaded(movies: r)),
      );
    });
  }
}
