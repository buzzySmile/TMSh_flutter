import 'package:equatable/equatable.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

abstract class ShortlistEvent extends Equatable {
  const ShortlistEvent();
}

class ShortlistAdd extends ShortlistEvent {
  ShortlistAdd(this._movie);

  final TMDbMovieCard _movie;
  TMDbMovieCard get movie => _movie;

  @override
  List<Object> get props => [_movie];

  @override
  String toString() {
    return "AddMovie {$movie}";
  }
}

class ShortlistRemove extends ShortlistEvent {
  ShortlistRemove(this._movie);

  final TMDbMovieCard _movie;
  TMDbMovieCard get movie => _movie;

  @override
  List<Object> get props => [_movie];

  @override
  String toString() {
    return "RemoveMovie {$movie}";
  }
}
