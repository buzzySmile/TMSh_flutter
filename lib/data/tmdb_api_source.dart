import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

import 'package:tmsh_flutter/data/api_key.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_error.dart';
import 'package:tmsh_flutter/data/models/tmdb_search_movies.dart';
import 'package:tmsh_flutter/data/models/tmdb_search_error.dart';

const int MAX_SEARCH_RESULTS = 5;

class TMDbApiSource {
  static const String baseUrl = 'api.themoviedb.org';
  final http.Client /*!*/ client;

  TMDbApiSource(this.client);

  Future<TMDbSearchMovies> searchMovie(
      {@required required String query, int pageIndex: 1}) async {
    var uri = Uri.https(
      baseUrl,
      '3/search/movie',
      <String, String>{
        'query': '$query',
        'page': '$pageIndex',
        'api_key': API_KEY,
        'language': 'en-US',
        'include_adult': 'false',
        //'year': '',
      },
    );

    final response = await client.get(uri);

    // delay to simulate slow network
    // await Future.delayed(const Duration(seconds: 1));

    if (response.statusCode == 200) {
      return TMDbSearchMovies.fromJSON(json.decode(response.body));
    } else {
      throw TMDbSearchError(json.decode(response.body)['errors'][0]);
    }
  }

  Future<TMDbMovieCard> fetchMovieInfo({required int movieId}) async {
    var uri = Uri.https(
      baseUrl,
      '3/movie/${movieId.toString()}',
      <String, String>{
        'api_key': API_KEY,
        'language': 'en-US',
      },
    );

    final response = await client.get(uri);

    // delay to simulate slow network
    // await Future.delayed(const Duration(seconds: 1));

    if (response.statusCode == 200) {
      return TMDbMovieCard.fromJson(json.decode(response.body));
    } else {
      throw TMDbMovieError(json.decode(response.body)['status_message']);
    }
  }
}
