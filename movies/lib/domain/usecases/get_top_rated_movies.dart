import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

class GetTopRatedMovies {
  final MovieRepository repository;

  GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return repository.getTopRatedMovies();
  }
}
