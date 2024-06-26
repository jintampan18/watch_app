import 'package:equatable/equatable.dart';
import 'genre.dart';

class TvSeriesDetail extends Equatable {
  const TvSeriesDetail({
    required this.id,
    required this.name,
    required this.genres,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
  });

  final int id;
  final String name;
  final List<Genre> genres;
  final String posterPath;
  final double voteAverage;
  final String overview;
  final int numberOfSeasons;
  final int numberOfEpisodes;

  @override
  List<Object?> get props => [
        id,
        name,
        genres,
        posterPath,
        voteAverage,
        overview,
        numberOfEpisodes,
        numberOfSeasons,
      ];
}
