import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

const testTvSeriesDetail = TvSeriesDetail(
  genres: [Genre(id: 1, name: 'Action')],
  id: 66732,
  name: "Stranger Things",
  numberOfEpisodes: 34,
  numberOfSeasons: 4,
  overview: "Stranger Things",
  posterPath: "/49WJfeN0moxb9IPfGn8AIqMGskD.jpg",
  voteAverage: 8.6,
);

final testTvSeries = TvSeries(
  name: "fdsfas",
  firstAirDate: "123",
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: const [14, 28],
  id: 557,
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  originCountry: const ['213', '33'],
  originalLanguage: "ID",
  originalName: "fdfasda",
  voteAverage: 7.2,
  voteCount: 13507,
);

final testTvSeriesList = [testTvSeries];

const testTvSeriesTable = TvSeriesTable(
  id: 111,
  name: "the last of ...",
  posterPath: "gambar.jpg",
  overview: "bagus",
);

final testTvSeriesMap = {
  'id': 111,
  'overview': 'bagus',
  'posterPath': 'gambar.jpg',
  'title': 'the last of ...',
};

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 111,
  name: "the last of ...",
  posterPath: "gambar.jpg",
  overview: "bagus",
);
