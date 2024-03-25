import 'dart:async';

import 'package:movies/data/models/movie_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tv_series/data/models/tv_series_table.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblMovieWatchlist = 'movieWatchlist';
  static const String _tblTvSeriesWatchlist = 'tvSeriesWatcthlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/watch_app.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE  $_tblTvSeriesWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  // Movie
  Future<int> insertWatchlistMovies(MovieTable movie) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movie.toJson());
  }

  Future<int> removeWatchlistMovies(MovieTable movie) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }

  // Tv-Series
  Future<int> insertWatchlistTvSeries(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.insert(_tblTvSeriesWatchlist, tvSeries.toJson());
  }

  Future<int> removeWatchlistTvSeries(TvSeriesTable tvSeries) async {
    final db = await database;
    return await db!.delete(
      _tblTvSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [tvSeries.id],
    );
  }

  Future<Map<String, dynamic>?> getTvSeriesById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvSeriesWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvSeries() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblTvSeriesWatchlist);

    return results;
  }
}
