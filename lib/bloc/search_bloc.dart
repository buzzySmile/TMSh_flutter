import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/data/models/tmdb_search_movies.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';

class SearchState {
  SearchState();
  factory SearchState._loading() = SearchStateLoading;
  factory SearchState._ready(TMDbSearchMovies searchResult) {
    return SearchStateReady(searchResult);
  }
}

class SearchStateInit extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateReady extends SearchState {
  List<TMDbMovieCard> _movieItems;
  SearchStateReady(TMDbSearchMovies searchResult) {
    _movieItems = searchResult.movies;
  }

  List<TMDbMovieCard> get movies => _movieItems;
}

class SearchBloc {
  TMDbApiSource tmdbClient = new TMDbApiSource(new http.Client());

  final _searchQueryController = StreamController<String>();
  // sink for inputs search query text
  StreamSink<String> get inSearchQuery => _searchQueryController.sink;

  final _moviesController = StreamController<SearchState>();
  // States of search process and search result
  Sink<SearchState> get _inMoviesResult => _moviesController.sink;
  Stream<SearchState> get outMoviesResult => _moviesController.stream;

  SearchBloc() {
    // Whenever there is a new search query, we want to fetch movies
    _searchQueryController.stream.listen(_fetchSearchMovies);
  }

  void _fetchSearchMovies(String queryText) {
    if (queryText.isEmpty) {
      _inMoviesResult.add(SearchStateInit());
      return;
    }

    _inMoviesResult.add(SearchState._loading());
    tmdbClient.searchMovie(query: queryText).then((searchResult) =>
        _inMoviesResult.add(SearchState._ready(searchResult)));
  }

  void dispose() {
    _searchQueryController.close();
    _moviesController.close();
  }
}
