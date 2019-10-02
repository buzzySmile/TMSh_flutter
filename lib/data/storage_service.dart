import 'package:rxdart/rxdart.dart';
import 'package:sembast/sembast.dart';

import 'package:tmsh_flutter/data/database.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

abstract class StorageService {
  Future<void> saveMovie(TMDbMovieCard movie);
  Future<void> removeMovie(TMDbMovieCard movie);

  // Stream<List<TMDbMovieCard>> shortlistStream();
  Future<List<TMDbMovieCard>> loadShortlist();
}

class StorageServiceImpl implements StorageService {
  static const String shortlistName = 'shortlist';

  //final _shortlistController = PublishSubject<List<TMDbMovieCard>>();

  final _store = intMapStoreFactory.store(shortlistName);

  Future<Database> get _database async => await AppDatabase.instance.database;

  @override
  Future saveMovie(TMDbMovieCard movie) async {
    final finder = Finder(filter: Filter.equals('id', movie.id));

    final key = await _store.findKey(await _database, finder: finder);
    print('Key for ${movie.title} = $key');
    if (key == null) {
      final savedKey = await _store.add(await _database, movie.toMap());
      print('Movie ${movie.title} saved with key $savedKey');
    } else {
      final count = await _store.update(
        await _database,
        movie.toMap(),
        finder: finder,
      );
      print('Movie ${movie.title} with key $key updated $count times ');
    }
  }

  @override
  Future<List<TMDbMovieCard>> loadShortlist() async {
    final recordSnapshots = await _store.find(
      await _database,
    );

    print("DB: found recordSnapshots ${recordSnapshots.length} ");

    // Making a List<Fruit> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final movie = TMDbMovieCard.fromJSON(snapshot.value);
      return movie;
    }).toList();
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
