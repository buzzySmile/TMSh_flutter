import 'package:meta/meta.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

@immutable
class ShortlistState {
  final List<TMDbMovieCard> shortlist;

  ShortlistState({
    this.shortlist = const [],
  });

  @override
  String toString() {
    return 'ShortlistState{shortlist: ${(shortlist).map((movie) => "(${movie.id})${movie.title}")}, }';
  }
}
