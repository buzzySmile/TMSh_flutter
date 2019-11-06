import 'package:redux/redux.dart';
import 'package:tmsh_flutter/redux/actions/actions.dart';
import 'package:tmsh_flutter/redux/app_state.dart';

void saveShortlist(AppState state) async {}

Future<AppState> loadShortlist() async {
  return AppState();
}

void appMiddlware(
    Store<AppState> store, action, NextDispatcher nextDispatcher) {
  nextDispatcher(action);

  if (action is GetShortlistAction) {
    loadShortlist();
  }

  if (action is AddMovieAction || action is DeleteMovieAction) {
    saveShortlist(store.state);
  }
}
