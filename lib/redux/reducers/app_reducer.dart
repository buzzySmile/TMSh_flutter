import 'package:redux/redux.dart';
import 'package:tmsh_flutter/redux/actions/actions.dart';
import 'package:tmsh_flutter/redux/app_state.dart';

// with usage combineReducers from package:redux lib
final Reducer<AppState> appReducer = combineReducers<AppState>([
  TypedReducer<AppState, ShortlistLoadedAction>(_initShortlist),
  TypedReducer<AppState, CommitMovieAction>(_addMovie),
]);

AppState _initShortlist(
  AppState state,
  ShortlistLoadedAction action,
) {
  return state.rebuild((b) => b..movies.addAll(action.movies));
}

AppState _addMovie(
  AppState state,
  CommitMovieAction action,
) {
  if (state.movies.contains(action.movie)) {
    return state.rebuild((b) => b..movies.remove(action.movie));
    // return List.from(state.movies).where((movie) => movie.id != action.movie.id);
  } else {
    return state.rebuild((b) => b..movies.add(action.movie));
    // return List.from(state.movies)..add(action.movie);
  }
}
