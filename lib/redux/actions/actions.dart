import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

class GetShortlistAction {
  @override
  String toString() {
    return 'GetShortlistAction{}';
  }
}

class ShortlistLoadedAction {
  final List<TMDbMovieCard> movies;

  ShortlistLoadedAction(this.movies);

  @override
  String toString() {
    return 'ShortlistLoadedAction{$movies}';
  }
}

class SearchMovieAction {
  final String searchText;

  SearchMovieAction(this.searchText);

  @override
  String toString() {
    return 'SearchMovieAction{todo: $searchText}';
  }
}

class CommitMovieAction {
  final TMDbMovieCard movie;

  CommitMovieAction(this.movie);

  @override
  String toString() {
    return 'CommitMovieAction{$movie}';
  }
}
