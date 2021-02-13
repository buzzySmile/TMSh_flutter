import 'dart:developer' as developer;

import 'package:rxdart/rxdart.dart';
import 'package:sembast/sembast.dart';

import 'package:tmsh_flutter/data/databases/database.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

import './repository.dart';

class SembastShortlistRepository implements ShortlistRepository {
  static const String shortlistName = 'shortlist';

  void dprint(String msg, {Object error}) =>
      developer.log(msg, name: '>>> ShortlistDB' /*, error: jsonEncode(error)*/
          );

  SembastShortlistRepository([List<TMDbMovieCard> seedValue = const []])
      : this._shortlistSubject =
            BehaviorSubject<List<TMDbMovieCard>>.seeded(seedValue);

  final BehaviorSubject<List<TMDbMovieCard>> _shortlistSubject;

  bool _loaded = false;

  final _store = intMapStoreFactory.store(shortlistName);

  Future<Database> get _database async => await SembastDb.instance.database;

  @override
  List<TMDbMovieCard> get value => _shortlistSubject.value;

  @override
  Future saveMovie(TMDbMovieCard movie) async {
    final finder = Finder(filter: Filter.equals('id', movie.id));

    final key = await _store.findKey(
      await _database,
      finder: finder,
    );

    if (key == null) {
      _store
          .add(
            await _database,
            movie.toMap(),
          )
          .then((savedKey) =>
              dprint('Movie ${movie.title} saved with key $savedKey'));
    } else {
      _store
          .update(
            await _database,
            movie.toMap(),
            finder: finder,
          )
          .then((count) => dprint(
              'Movie ${movie.title} with key $key updated $count times '));
    }
  }

  @override
  Stream<List<TMDbMovieCard>> shortlist() {
    if (!_loaded) _loadShortlist();

    dprint("!!!Shortlist stream called!!!");

    return _shortlistSubject.stream;
  }

  Future _loadShortlist() async {
    _loaded = true;

    var query = _store.query();
    query.onSnapshots(await _database).listen((snapshots) {
      dprint("Stream from DB: ${snapshots.length} records");
      _shortlistSubject.add(
        List.unmodifiable(
          []..addAll(snapshots
              .map(
                (snapshot) => TMDbMovieCard.fromJSON(snapshot.value),
              )
              .toList()),
        ),
      );
    });
  }

  @override
  Future removeMovie(TMDbMovieCard movie) async {
    final finder = Finder(filter: Filter.equals('id', movie.id));

    await _store.delete(
      await _database,
      finder: finder,
    );
  }
}
