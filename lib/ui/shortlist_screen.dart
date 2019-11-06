import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/shortlist_bloc/bloc.dart';
import 'package:tmsh_flutter/ui/widget/movie_card.dart';

class ShortlistScreen extends StatefulWidget {
  ShortlistScreen();

  @override
  _ShortlistScreenState createState() => _ShortlistScreenState();
}

class _ShortlistScreenState extends State<ShortlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY SHORTLIST'),
      ),
      body: BlocBuilder<ShortlistBloc, ShortlistState>(
        builder: (BuildContext context, ShortlistState state) {
          if (state is ShortlistLoading) return CircularProgressIndicator();

          if (state is ShortlistLoaded) {
            List<TMDbMovieCard> shortMovieList = state.movies;
            return ListView.builder(
                itemCount: shortMovieList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: GestureDetector(
                      child: MovieCard(
                        movieData: shortMovieList[index],
                        onShortlist: (movie) =>
                            BlocProvider.of<ShortlistBloc>(context)
                                .add(ShortlistAdd(movie)),
                      ),
                      onTap: () => Navigator.pushNamed(context, '/movie',
                          arguments: shortMovieList[index]),
                    ),
                  );
                });
          }
          return Center(
            child: Text('Something went wrong!'),
          );
        },
      ),
    );
  }
}
