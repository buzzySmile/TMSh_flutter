import 'dart:async';

import 'package:rxdart/rxdart.dart';
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

class ShortlistState {
  final List<TMDbMovieCard> _movieList;

  ShortlistState(this._movieList);

  List<TMDbMovieCard> get shortlist => _movieList;

  int get shortlistLength => _movieList.length;
}

class ShortlistAdd extends ShortlistEvent {
  ShortlistAdd(TMDbMovieCard movie) : super(movie);
}

class ShortlistRemove extends ShortlistEvent {
  ShortlistRemove(TMDbMovieCard movie) : super(movie);
}

class ShortlistBloc extends BlocBase {
  final Set<TMDbMovieCard> _shortlist;

  List<TMDbMovieCard> get shortlist => _shortlist.toList();

  ShortlistBloc() : _shortlist = Set<TMDbMovieCard>() {
    _shortlistEventController.stream.listen(_handleShortlist);
  }

  final _shortlistEventController = PublishSubject<ShortlistEvent>();

  Sink<ShortlistEvent> get inShortlist => _shortlistEventController.sink;
  Stream<ShortlistEvent> get outShortlist => _shortlistEventController.stream;

  final _shortlistStateController = PublishSubject<ShortlistState>();

  Sink<ShortlistState> get _inShortlistState => _shortlistStateController.sink;
  Stream<ShortlistState> get outShortlistState =>
      _shortlistStateController.stream;

  _handleShortlist(ShortlistEvent event) {
    if (!_shortlist.contains(event.movie))
      _shortlist.add(event.movie);
    else
      _shortlist.remove(event.movie);

    _inShortlistState.add(ShortlistState(_shortlist.toList()));
  }

  @override
  void dispose() {
    _shortlistEventController.close();
    _shortlistStateController.close();
  }
}
