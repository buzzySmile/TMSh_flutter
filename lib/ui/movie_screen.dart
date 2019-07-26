import 'package:flutter/material.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/ui/component/shortlist_button.dart';

class MovieScreen extends StatefulWidget {
  final TMDbMovieCard _movieCard;

  MovieScreen(this._movieCard);

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: <Widget>[
        // Icon that gives direct access to the favorites
        // displays "real-time" number of favorites
        ShortlistButton(),
      ]),
      body: Center(
        child: Text('${widget._movieCard.title}'),
      ),
    );
  }
}
