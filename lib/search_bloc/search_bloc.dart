import 'dart:async';
import 'package:redux/redux.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc/bloc.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final TMDbApiSource _tmdbClient;
  final Store _store;

  final List<TMDbMovieCard> _movieList = <TMDbMovieCard>[];
  int _pageIndex = 1;
  int _totalPages = 0;
  String _queryText = '';

  SearchBloc(this._store, this._tmdbClient);

  @override
  Stream<SearchState> transformEvents(
    Stream<SearchEvent> events,
    Stream<SearchState> Function(SearchEvent event) next,
  ) {
    return (events as Observable<SearchEvent>)
        .debounceTime(
          Duration(milliseconds: 750),
        )
        .switchMap(next);
  }

  @override
  SearchState get initialState => SearchStateInit();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    // in case NEW search query
    if (event is SearchEventQuery) {
      _resetQuery();
      if (event.query.isEmpty) {
        yield SearchStateInit();
        return;
      } else {
        _queryText = event.query;
        yield SearchState.loading();
      }
    }

    // in case FETCH NEXT page
    if (event is SearchEventNext) {
      if (_pageIndex >= _totalPages) return;
      _pageIndex++;
    }

    // start search query and handle search result
    final searchResult =
        await _tmdbClient.searchMovie(query: _queryText, pageIndex: _pageIndex);

    _movieList.addAll(searchResult.movies);
    _pageIndex = searchResult.pageIndex;
    _totalPages = searchResult.totalPages;
    yield SearchState.ready(_movieList);
  }

  void _resetQuery() {
    _queryText = '';
    _pageIndex = 1;
    _totalPages = 0;

    _movieList.clear();
  }
}
