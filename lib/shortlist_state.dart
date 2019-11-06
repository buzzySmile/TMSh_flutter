import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

part 'shortlist_state.g.dart';

abstract class ShortlistState
    implements Built<ShortlistState, ShortlistStateBuilder> {
  static Serializer<ShortlistState> get serializer =>
      _$shortlistStateSerializer;

  BuiltList<TMDbMovieCard> get movies;

  ShortlistState._();

  factory ShortlistState([updates(ShortlistStateBuilder b)]) =>
      _$ShortlistState((b) => b
        ..movies = ListBuilder<TMDbMovieCard>([])
        ..update(updates));

  factory ShortlistState.fromMovies(List<TMDbMovieCard> todos) =>
      ShortlistState((b) => b..movies = ListBuilder<TMDbMovieCard>(todos));

  @override
  String toString() {
    return 'ShortlistState{shortlist: ${(movies).map((movie) => "(${movie.id})${movie.title}")}, }';
  }
}
