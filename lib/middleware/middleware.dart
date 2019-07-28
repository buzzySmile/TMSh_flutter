import 'package:redux/redux.dart';
import 'package:tmsh_flutter/actions/actions.dart';
import 'package:tmsh_flutter/shortlist_state.dart';

void saveShortlist(ShortlistState state) async {}

Future<ShortlistState> loadShortlist() async {
  return ShortlistState();
}

void shortlistMiddlware(
    Store<ShortlistState> store, action, NextDispatcher nextDispatcher) {
  nextDispatcher(action);

  if (action is GetShortlistAction) {
    loadShortlist();
  }

  if (action is AddMovieAction || action is DeleteMovieAction) {
    saveShortlist(store.state);
  }
}
