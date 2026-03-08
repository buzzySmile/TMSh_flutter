import 'package:flutter/material.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/ui/movie_screen.dart';
import 'package:tmsh_flutter/ui/shortlist_screen.dart';
import 'package:tmsh_flutter/ui/view/search_screen_view.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => SearchScreenView());
      case '/movie':
        if (args is TMDbMovieCard) {
          return MaterialPageRoute(builder: (context) => MovieScreen(args));
        }
        return _generateErrorRoute();
      case '/shortlist':
        return MaterialPageRoute(builder: (context) => ShortlistScreen());
      default:
        return _generateErrorRoute();
    }
  }

  static Route<dynamic> _generateErrorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('error'),
        ),
        body: Center(
          child: Text('error'),
        ),
      );
    });
  }
}
