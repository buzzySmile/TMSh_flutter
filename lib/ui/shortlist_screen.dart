import 'package:flutter/material.dart';
import 'package:tmsh_flutter/bloc/bloc_provider.dart';
import 'package:tmsh_flutter/bloc/shortlist_bloc.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/ui/widget/movie_card.dart';

class ShortlistScreen extends StatefulWidget {
  ShortlistScreen();

  @override
  _ShortlistScreenState createState() => _ShortlistScreenState();
}

class _ShortlistScreenState extends State<ShortlistScreen> {
  ShortlistBloc _shortlistBloc;

  @override
  void initState() {
    super.initState();
    _shortlistBloc = BlocProvider.of<ShortlistBloc>(context);
    _shortlistBloc.inShortlist.add(ShortlistLoad());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY SHORTLIST'),
      ),
      body: StreamBuilder(
        stream: _shortlistBloc.outShortlistState,
        initialData: ShortlistState.empty(),
        builder:
            (BuildContext context, AsyncSnapshot<ShortlistState> snapshot) {
          List<TMDbMovieCard> shortMovieList = snapshot.data.shortlist;
          return (shortMovieList == null)
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: shortMovieList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: GestureDetector(
                        child: MovieCard(
                          movieData: shortMovieList[index],
                          onShortlist: (movie) => _shortlistBloc.inShortlist
                              .add(ShortlistAdd(movie)),
                        ),
                        onTap: () => Navigator.pushNamed(context, '/movie',
                            arguments: shortMovieList[index]),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
