import 'package:built_collection/built_collection.dart';
import 'package:redux/redux.dart';
import 'package:tmsh_flutter/redux/actions/actions.dart';
import 'package:tmsh_flutter/redux/app_state.dart';

// with usage combineReducers from package:redux lib
final Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, ShortlistLoadedAction>(_initShortlist),
]);

AppState _initShortlist(
  AppState state,
  ShortlistLoadedAction action,
) {
  return state.rebuild((b) => b..movies = action.movies.build().toBuilder());
}
