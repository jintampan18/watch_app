import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/genre.dart';

class GenreModel extends Equatable {
  const GenreModel({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  GenreMovies toEntity() {
    return GenreMovies(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}
