import 'package:meta/meta.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

@immutable
class ShortlistState {
  final Set<TMDbMovieCard> _movies = Set<TMDbMovieCard>();

  ShortlistState();

  ShortlistState.clone(ShortlistState shortlist) {
    _movies.addAll(shortlist._movies);
  }

  void add(TMDbMovieCard movie) {
    _movies.add(movie);
  }

  void remove(TMDbMovieCard movie) {
    _movies.remove(movie);
  }

  @override
  String toString() {
    return 'ShortlistState{shortlist: ${(_movies).map((movie) => "(${movie.id})${movie.title}")}, }';
  }
}
