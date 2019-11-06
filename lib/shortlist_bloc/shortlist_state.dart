import 'package:equatable/equatable.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

abstract class ShortlistState extends Equatable {
  const ShortlistState();
}

class ShortlistLoading extends ShortlistState {
  @override
  List<Object> get props => [];
}

class ShortlistLoaded extends ShortlistState {
  final List<TMDbMovieCard> movies;

  ShortlistLoaded({this.movies});

  factory ShortlistLoaded.empty() {
    return ShortlistLoaded(movies: const []);
  }

  @override
  List<Object> get props => [movies];
}
