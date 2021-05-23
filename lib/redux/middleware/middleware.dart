import 'package:kiwi/kiwi.dart';
import 'package:redux/redux.dart';
import 'package:tmsh_flutter/data/shortlist_repository.dart';
import 'package:tmsh_flutter/redux/actions/actions.dart';
import 'package:tmsh_flutter/redux/app_state.dart';

final storage = KiwiContainer().resolve<ShortlistRepositoryImpl>();

void saveShortlist(AppState state) async {}

Future<AppState> loadShortlist() async {
  return AppState();
}

void appMiddlware(
  Store<AppState> store,
  action,
  NextDispatcher nextDispatcher,
) {
  nextDispatcher(action);

  if (action is GetShortlistAction) {
    storage
        .shortlist()
        .listen((movies) => store.dispatch(ShortlistLoadedAction(movies)));
  }

  if (action is CommitMovieAction) {
    if (store.state.movies!.contains(action.movie)) {
      storage.removeMovie(action.movie);
    } else {
      storage.saveMovie(action.movie);
    }
  }
}
