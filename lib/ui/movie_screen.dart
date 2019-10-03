import 'package:flutter/material.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';

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
      appBar: AppBar(
        title: Text('${widget._movieCard.title}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child:
                    Image.network(widget._movieCard.poster, fit: BoxFit.cover)),
          ),
          Text(
            '${widget._movieCard.overview}',
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Text(
            'Rating: ${widget._movieCard.voteAverage}',
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
