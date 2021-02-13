import 'package:rxdart/rxdart.dart';

import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

import './repository.dart';

class SQLiteShortlistRepository implements ShortlistRepository {
  static const String shortlistName = 'shortlist';

  SQLiteShortlistRepository([List<TMDbMovieCard> seedValue = const []])
      : this._shortlistSubject =
            BehaviorSubject<List<TMDbMovieCard>>.seeded(seedValue);

  final BehaviorSubject<List<TMDbMovieCard>> _shortlistSubject;

  @override
  List<TMDbMovieCard> get value => [];

  @override
  Future<void> saveMovie(TMDbMovieCard movie) {}

  @override
  Future<void> removeMovie(TMDbMovieCard movie) {}

  @override
  Stream<List<TMDbMovieCard>> shortlist() {}
}

// Future<List<Movie>> getMovies() async {
//   var dbClient = await db;
//   List<Map> res = await dbClient.query("Movies");
//   return res.map((m) => Movie.fromDb(m)).toList();
// }

// Future<Movie> getMovie(String id) async {
//   var dbClient = await db;
//   var res = await dbClient.query("Movies", where: "id = ?", whereArgs: [id]);
//   if (res.length == 0) return null;
//   return Movie.fromDb(res[0]);
// }

// Future<int> addMovie(Movie movie) async {
//   var dbClient = await db;
//   try {
//     int res = await dbClient.insert("Movies", movie.toMap());
//     print("Movie added $res");
//     return res;
//   } catch (e) {
//     int res = await updateMovie(movie);
//     return res;
//   }
// }

// Future<int> updateMovie(Movie movie) async {
//   var dbClient = await db;
//   int res = await dbClient.update("Movies", movie.toMap(),
//       where: "id = ?", whereArgs: [movie.id]);
//   print("Movie updated $res");
//   return res;
// }

// Future<int> deleteMovie(String id) async {
//   var dbClient = await db;
//   var res = await dbClient.delete("Movies", where: "id = ?", whereArgs: [id]);
//   print("Movie deleted $res");
//   return res;
// }
