import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

class GetShortlistAction {}

class DeleteMovieAction {
  final int id;

  DeleteMovieAction(this.id);

  @override
  String toString() {
    return 'DeleteMovieAction{id: $id}';
  }
}

class AddMovieAction {
  final TMDbMovieCard movie;

  AddMovieAction(this.movie);

  @override
  String toString() {
    return 'AddMovieAction{todo: $movie}';
  }
}
