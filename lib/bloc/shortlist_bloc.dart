import 'dart:async';

import 'package:tmsh_flutter/bloc/bloc_provider.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

class ShortlistEvent {
  final TMDbMovieCard _movie;
  TMDbMovieCard get movie => _movie;

  ShortlistEvent(this._movie);
  factory ShortlistEvent.add(movie) {
    return ShortlistAdd(movie);
  }
  factory ShortlistEvent.remove(movie) {
    return ShortlistRemove(movie);
  }
}

class ShortlistAdd extends ShortlistEvent {
  ShortlistAdd(TMDbMovieCard movie) : super(movie);
}

class ShortlistRemove extends ShortlistEvent {
  ShortlistRemove(TMDbMovieCard movie) : super(movie);
}

class ShortlistBloc extends BlocBase {
  final Set<TMDbMovieCard> _shortlist;

  ShortlistBloc() : _shortlist = Set<TMDbMovieCard>();

  final _shortlistEventController = StreamController<ShortlistEvent>();

  Sink<ShortlistEvent> get inShortlist => _shortlistEventController.sink;
  Stream<ShortlistEvent> get outShortlist => _shortlistEventController.stream;

  @override
  void dispose() {
    _shortlistEventController.close();
    // TODO: implement dispose
  }
}
