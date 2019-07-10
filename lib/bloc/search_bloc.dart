import 'dart:async';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';

// Input Events for BLoC, use by external sоurces
class SearchEvent {
  SearchEvent();
  factory SearchEvent.query(String searchQuery) {
    return SearchEventQuery(searchQuery);
  }
  factory SearchEvent.next() = SearchEventNext;
}

class SearchEventQuery extends SearchEvent {
  final String query;
  SearchEventQuery(this.query);
}

class SearchEventNext extends SearchEvent {}
// ==========================================

// Output States that BLoC produces as result
class SearchState {
  SearchState();
  factory SearchState._loading() = SearchStateLoading;
  factory SearchState._ready(List<TMDbMovieCard> searchResult) {
    return SearchStateReady(searchResult);
  }
}

class SearchStateInit extends SearchState {}

class SearchStateLoading extends SearchState {}

class SearchStateReady extends SearchState {
  final List<TMDbMovieCard> movies;
  SearchStateReady(this.movies);
}
// ==========================================

class SearchBloc {
  final TMDbApiSource _tmdbClient;

  final List<TMDbMovieCard> _movieList = <TMDbMovieCard>[];
  int _pageIndex = 1;
  int _totalPages = 0;
  String _queryText = '';

  final _searchEventController = StreamController<SearchEvent>();
  // sink for input search events
  StreamSink<SearchEvent> get inSearchEvent => _searchEventController.sink;

  final _searchStateController = StreamController<SearchState>();
  // States of search process and search result
  Sink<SearchState> get _inSearchState => _searchStateController.sink;
  Stream<SearchState> get outSearchState => _searchStateController.stream;

  SearchBloc(this._tmdbClient) {
    // Whenever there is a new Search Event, we want to handle it
    _searchEventController.stream.listen(_handleSearchEvent);
  }

  // map SearchEvents to SearchState
  void _handleSearchEvent(SearchEvent searchEvent) {
    // in case NEW search query
    if (searchEvent is SearchEventQuery) {
      _resetQuery();
      if (searchEvent.query.isEmpty) {
        _inSearchState.add(SearchStateInit());
        return;
      } else {
        _queryText = searchEvent.query;
        _inSearchState.add(SearchState._loading());
      }
    }

    // in case FETCH NEXT page
    if (searchEvent is SearchEventNext) {
      if (_pageIndex >= _totalPages) return;
      _pageIndex++;
    }

    // start search query and handle search result
    _tmdbClient
        .searchMovie(query: _queryText, pageIndex: _pageIndex)
        .then((searchResult) {
      _movieList.addAll(searchResult.movies);
      _pageIndex = searchResult.pageIndex;
      _totalPages = searchResult.totalPages;
      _inSearchState.add(SearchState._ready(_movieList));
    });
  }

  void _resetQuery() {
    _queryText = '';
    _pageIndex = 1;
    _totalPages = 0;

    _movieList.clear();
  }

  void dispose() {
    _searchEventController.close();
    _searchStateController.close();
  }
}
