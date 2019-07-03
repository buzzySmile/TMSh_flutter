import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

class TMDbSearchMovies {
  final int pageIndex;
  final int totalResults;
  final int totalPages;
  final List<TMDbMovieCard> movies;

  TMDbSearchMovies.fromJSON(Map<String, dynamic> json)
      : pageIndex = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'],
        movies = (json['results'] as List)
            .map((json) => TMDbMovieCard.fromJSON(json))
            .toList();
}
