import 'package:equatable/equatable.dart';

class GenreMovies extends Equatable {
  const GenreMovies({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object> get props => [id, name];
}
