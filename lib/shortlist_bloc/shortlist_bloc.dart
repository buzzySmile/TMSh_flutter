import 'package:bloc/bloc.dart';
import 'package:redux/redux.dart';
import 'package:tmsh_flutter/data/shortlist_repository.dart';
import 'package:tmsh_flutter/shortlist_bloc/shortlist_event.dart';
import 'package:tmsh_flutter/shortlist_bloc/shortlist_state.dart';

class ShortlistBloc extends Bloc<ShortlistEvent, ShortlistState> {
  final ShortlistRepository _storage;
  final Store _store;

  ShortlistBloc(
    this._store,
    this._storage,
  );

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
