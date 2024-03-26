import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies.dart';

part 'search_event.dart';
part 'search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies usecases;

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  MovieSearchBloc(this.usecases) : super(MovieSearchInitial()) {
    on<MovieSearchQueryEvent>((event, emit) async {
      final query = event.query;

      emit(MovieSearchLoading());
      final result = await usecases.execute(query);

      result.fold(
        (l) => emit(MovieSearchError(message: l.message)),
        (r) => emit(MovieSearchLoaded(result: r)),
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
