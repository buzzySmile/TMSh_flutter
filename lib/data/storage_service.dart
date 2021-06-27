import 'package:rxdart/rxdart.dart';
import 'package:sembast/sembast.dart';

import 'package:tmsh_flutter/data/database.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

abstract class StorageService {
  Future<void> saveMovie(TMDbMovieCard movie);
  Future<void> removeMovie(TMDbMovieCard movie);

  Stream<List<TMDbMovieCard>> shortlist();
}

class StorageServiceImpl implements StorageService {
  static const String shortlistName = 'shortlist';

  StorageServiceImpl([List<TMDbMovieCard> seedValue = const []])
      : this._shortlistSubject =
            BehaviorSubject<List<TMDbMovieCard>>.seeded(seedValue);

  final BehaviorSubject<List<TMDbMovieCard>> _shortlistSubject;

  bool _loaded = false;

  final _store = intMapStoreFactory.store(shortlistName);

  Future<Database> get _database async => await AppDatabase.instance.database;

  @override
  Future saveMovie(TMDbMovieCard movie) async {
    final finder = Finder(filter: Filter.equals('id', movie.id));

    final key = await _store.findKey(await _database, finder: finder);
    print('Key for ${movie.title} = $key');
    if (key == null) {
      final savedKey = await _store.add(await _database, movie.toJson());
      print('Movie ${movie.title} saved with key $savedKey');
    } else {
      final count = await _store.update(
        await _database,
        movie.toJson(),
        finder: finder,
      );
      print('Movie ${movie.title} with key $key updated $count times ');
    }
  }

  @override
  Stream<List<TMDbMovieCard>> shortlist() {
    if (!_loaded) _loadShortlist();

    print('!!!Shortlist stream called!!!');

    return _shortlistSubject.stream;
  }

  Future _loadShortlist() async {
    _loaded = true;

    var query = _store.query() as QueryRef<int, Map<String, Object>>;
    query.onSnapshots(await _database).listen((snapshots) {
      print('Stream from DB: ${snapshots.length} records');
      _shortlistSubject.add(
        List.unmodifiable(snapshots
            .map(
              (snapshot) => TMDbMovieCard.fromJson(snapshot.value),
            )
            .toList()),
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
