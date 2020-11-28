import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  bool get loading;

  BuiltList<TMDbMovieCard> get movies;

  AppState._();

  factory AppState([updates(AppStateBuilder b)]) => _$AppState((b) => b
    ..loading = false
    ..movies = ListBuilder<TMDbMovieCard>([])
    ..update(updates));

  factory AppState.fromMovies(List<TMDbMovieCard> movieList) =>
      AppState((b) => b..movies = ListBuilder<TMDbMovieCard>(movieList));

  @override
  String toString() {
    final moviesString =
        movies.map((movie) => '\t\t[${movie.id}]: ${movie.title}').join('\n');
    return '\n\tloading: $loading,\n\tshortlist:\n$moviesString \n}';
  }
}
