import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/redux/actions/actions.dart';
import 'package:tmsh_flutter/redux/app_state.dart';

class MovieCard extends StatelessWidget {
  final TMDbMovieCard movieData;

  MovieCard({
    Key? key,
    required this.movieData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          movieData.hasPoster
              ? Image.network(movieData.poster, fit: BoxFit.cover)
              : Image(image: AssetImage('images/poster_placeholder.png')),
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
                      StoreConnector<AppState, _ViewModel>(
                        converter: (store) =>
                            _ViewModel.fromStore(store, movieData),
                        builder: (context, vm) {
                          return InkWell(
                            onTap: () => vm.onCommitMovie(movieData),
                            child: Icon(
                              Icons.star,
                              color: vm.isFavorite
                                  ? Colors.yellow
                                  : Colors.black38,
                            ),
                          );
                        },
                      ),
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

class _ViewModel {
  final bool isFavorite;
  final Function(TMDbMovieCard) onCommitMovie;

  _ViewModel({
    required this.isFavorite,
    required this.onCommitMovie,
  });

  factory _ViewModel.fromStore(
    Store<AppState> store,
    TMDbMovieCard movie,
  ) {
    return _ViewModel(
      isFavorite: store.state.movies!.contains(movie),
      onCommitMovie: (movie) => store.dispatch(CommitMovieAction(movie)),
    );
  }
}
