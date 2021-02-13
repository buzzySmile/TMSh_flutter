export 'sembast_shortlist.dart';
export 'sqlite_shortlist.dart';

import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

abstract class ShortlistRepository {
  List<TMDbMovieCard> get value;

  Future<void> saveMovie(TMDbMovieCard movie);
  Future<void> removeMovie(TMDbMovieCard movie);

  Stream<List<TMDbMovieCard>> shortlist();
}
