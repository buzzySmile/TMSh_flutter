import 'package:rxdart/rxdart.dart';
import 'package:tmsh_flutter/bloc/bloc_provider.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/data/storage_service.dart';

class ShortlistEvent {
  @override
  String toString() {
    return "ShortlistEvent: ";
  }
}

class ShortlistLoad extends ShortlistEvent {
  @override
  String toString() {
    return "${super.toString()}LoadMovieList {}";
  }
}

class ShortlistAdd extends ShortlistEvent {
  ShortlistAdd(this._movie);

  final TMDbMovieCard _movie;
  TMDbMovieCard get movie => _movie;

  @override
  String toString() {
    return "${super.toString()}AddMovie {$movie}";
  }
}

class ShortlistRemove extends ShortlistEvent {
  ShortlistRemove(this._movie);

  final TMDbMovieCard _movie;
  TMDbMovieCard get movie => _movie;

  @override
  String toString() {
    return "${super.toString()}RemoveMovie {$movie}";
  }
}

class ShortlistState {
  final List<TMDbMovieCard> _movieList;

  ShortlistState(this._movieList);

  factory ShortlistState.empty() {
    return ShortlistState(const []);
  }

  List<TMDbMovieCard> get shortlist => _movieList;

  int get shortlistLength => _movieList.length;
}

// ============================================================================
class ShortlistBloc extends BlocBase {
  // final Set<TMDbMovieCard> _shortlist;
  final StorageService _storage;

  // List<TMDbMovieCard> get shortlist => _shortlist.toList();

  ShortlistBloc(this._storage) /* : _shortlist = Set<TMDbMovieCard>()*/ {
    _shortlistEventController.stream.listen(_handleShortlist);
  }

  final _shortlistEventController = PublishSubject<ShortlistEvent>();

  Sink<ShortlistEvent> get inShortlist => _shortlistEventController.sink;
  Observable<ShortlistEvent> get outShortlist =>
      _shortlistEventController.stream;

  final _shortlistStateController = PublishSubject<ShortlistState>();

  Sink<ShortlistState> get _inShortlistState => _shortlistStateController.sink;
  Observable<ShortlistState> get outShortlistState =>
      _shortlistStateController.stream;

  _handleShortlist(ShortlistEvent event) async {
    print(event.toString());
    if (event is ShortlistLoad) {
      _inShortlistState.add(await _reloadShortlist());
    } else if (event is ShortlistAdd) {
      _storage.saveMovie(event.movie).then(
        (_) async {
          _inShortlistState.add(await _reloadShortlist());
        },
      );
    } else if (event is ShortlistRemove) {
      _storage.removeMovie(event.movie).then(
        (_) async {
          _inShortlistState.add(await _reloadShortlist());
        },
      );
    }
  }

  Future<ShortlistState> _reloadShortlist() async {
    final shortlist = await _storage.loadShortlist();
    return ShortlistState(shortlist);
  }

  @override
  void dispose() {
    _shortlistEventController.close();
    _shortlistStateController.close();
  }
}
