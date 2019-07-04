import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/data/models/tmdb_search_movies.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';
import 'package:tmsh_flutter/ui/widget/favorite_button.dart';
import 'package:tmsh_flutter/ui/widget/search_field.dart';

class SearchScreen extends StatefulWidget {
  final String title;

  SearchScreen({Key key, this.title}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TMDbApiSource tmdbClient;
  final List<TMDbMovieCard> _movieItems = <TMDbMovieCard>[];
  Future<TMDbSearchMovies> newMovies;
  // List<TMDbMovieCard> _movieItems = {};

  _SearchScreenState() {
    tmdbClient = TMDbApiSource(new http.Client());
  }

  void _textChanged(String queryText) async {
    print("_textChanged: " + queryText);
    this._clearItems();

    await Future.delayed(const Duration(milliseconds: 500));
    newMovies = tmdbClient.searchMovie(query: queryText);
    // .then((TMDbSearchMovies movies) {
    //   _movieItems.addAll(movies.movies);
    //   print(_movieItems.toString());
    // });
    // TODO network call
  }

  void _clearItems() {
    setState(() {
      _movieItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // Search bar - TextField for search query
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: SearchField(
                onChanged: (text) => this._textChanged(text),
              ),
            ),
          ),
          actions: <Widget>[
            // Icon that gives direct access to the favorites
            // displays "real-time" number of favorites
            FavoriteButton(child: const Icon(Icons.star)),
          ]),
      body: FutureBuilder(
        future: newMovies,
        builder: (context, AsyncSnapshot<TMDbSearchMovies> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<TMDbSearchMovies> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.movies.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                'https://image.tmdb.org/t/p/w185${snapshot.data.movies[index].posterPath}',
                fit: BoxFit.cover,
              ),
              //onTap: () => openDetailPage(snapshot.data, index),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
