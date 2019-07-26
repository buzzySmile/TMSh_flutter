import 'package:tmsh_flutter/actions/actions.dart';
import 'package:tmsh_flutter/shortlist_state.dart';

ShortlistState shortlistReducer(ShortlistState state, action) {
  if (action is AddMovieAction)
    return ShortlistState(
        shortlist: List.from(state.shortlist)..add(action.movie));

  if (action is DeleteMovieAction)
    return ShortlistState(
        shortlist:
            List.from(state.shortlist).where((movie) => movie.id != action.id));

  return ShortlistState(shortlist: []);
}

// with usage combineReducers from package:redux lib
// final shortlistCombReducer = combineReducers<List<TMDbMovieCard>>([
//   TypedReducer<List<TMDbMovieCard>, AddMovieAction>(_addMovie),
//   TypedReducer<List<TMDbMovieCard>, DeleteMovieAction>(_deleteMovie),
// ]);

// List<TMDbMovieCard> _addMovie(
//     List<TMDbMovieCard> movies, AddMovieAction action) {
//   return List.from(movies)..add(action.movie);
// }

// List<TMDbMovieCard> _deleteMovie(
//     List<TMDbMovieCard> movies, DeleteMovieAction action) {
//   return List.from(movies).where((movie) => movie.id != action.id);
// }
