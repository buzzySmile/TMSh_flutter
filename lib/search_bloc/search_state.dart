import 'package:equatable/equatable.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  factory SearchState.loading() = SearchStateLoading;
  factory SearchState.ready(List<TMDbMovieCard> searchResult) {
    return SearchStateReady(searchResult);
  }
}

class SearchStateInit extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateLoading extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchStateReady extends SearchState {
  final List<TMDbMovieCard> movies;
  SearchStateReady(this.movies);

  @override
  List<Object> get props => [movies];
}
