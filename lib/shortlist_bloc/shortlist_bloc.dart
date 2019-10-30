import 'package:bloc/bloc.dart';
import 'package:tmsh_flutter/data/storage_service.dart';
import 'package:tmsh_flutter/shortlist_bloc/shortlist_event.dart';
import 'package:tmsh_flutter/shortlist_bloc/shortlist_state.dart';

class ShortlistBloc extends Bloc<ShortlistEvent, ShortlistState> {
  final StorageService _storage;

  ShortlistBloc(this._storage);

  @override
  get initialState => ShortlistLoaded(movies: const []);

  @override
  Stream<ShortlistState> mapEventToState(
    ShortlistEvent event,
  ) async* {
    if (event is ShortlistAdd) {
      _storage.saveMovie(event.movie);
    } else if (event is ShortlistRemove) {
      _storage.removeMovie(event.movie);
    }

    yield* _storage.shortlist().map((slist) => ShortlistLoaded(movies: slist));
  }
}
