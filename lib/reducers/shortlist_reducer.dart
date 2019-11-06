import 'package:redux/redux.dart';
import 'package:tmsh_flutter/actions/actions.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/shortlist_state.dart';

ShortlistState shortlistReducer(ShortlistState state, action) {
  return ShortlistState.fromMovies(
      moviesReducer(state.movies.toList(), action));
}

// with usage combineReducers from package:redux lib
final Reducer<List<TMDbMovieCard>> moviesReducer =
    combineReducers<List<TMDbMovieCard>>([
  TypedReducer<List<TMDbMovieCard>, AddMovieAction>(_addMovie),
  TypedReducer<List<TMDbMovieCard>, DeleteMovieAction>(_deleteMovie),
]);

List<TMDbMovieCard> _addMovie(
  List<TMDbMovieCard> movies,
  AddMovieAction action,
) {
  return List.from(movies)..add(action.movie);
}

List<TMDbMovieCard> _deleteMovie(
  List<TMDbMovieCard> movies,
  DeleteMovieAction action,
) {
  return List.from(movies).where((movie) => movie.id != action.id);
}
