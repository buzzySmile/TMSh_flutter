import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tmsh_flutter/actions/actions.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/shortlist_state.dart';

class MovieCard extends StatelessWidget {
  final TMDbMovieCard movieData;

  MovieCard({
    Key key,
    this.movieData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<ShortlistState>(context);

    return SizedBox(
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(movieData.posterPath, fit: BoxFit.cover),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${movieData.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                  Expanded(
                    child: Text(
                      '${movieData.overview}',
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Rating: ${movieData.voteAverage}',
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      InkWell(
                        child: const Icon(
                          Icons.star,
                          color: Colors.black38,
                        ),
                        onTap: () => store.dispatch(AddMovieAction(movieData)),
                        //print('Add (id)${movieData.id} to Shortlist'),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
