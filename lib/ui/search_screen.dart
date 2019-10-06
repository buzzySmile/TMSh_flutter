import 'package:flutter/material.dart';
import 'package:tmsh_flutter/bloc/bloc_provider.dart';
import 'package:tmsh_flutter/bloc/shortlist_bloc.dart';
import 'package:tmsh_flutter/ui/widget/favorite_button.dart';
import 'package:tmsh_flutter/ui/widget/movie_card.dart';
import 'package:tmsh_flutter/ui/widget/search_field.dart';
import 'package:tmsh_flutter/bloc/search_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc _searchBloc = kiwi.Container().resolve<SearchBloc>();
  final ScrollController _scrollController = ScrollController();
  ShortlistBloc _shortlistBloc;

  @override
  void initState() {
    super.initState();
    _shortlistBloc = BlocProvider.of<ShortlistBloc>(context);
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
                onChanged: (text) =>
                    _searchBloc.inSearchEvent.add(SearchEvent.query(text)),
              ),
            ),
          ),
          actions: <Widget>[
            StreamBuilder(
              stream: _shortlistBloc.outShortlistState,
              initialData: ShortlistState.empty(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return FavoriteButton(
                  child: const Icon(Icons.star),
                  count: (snapshot.data is ShortlistState)
                      ? snapshot.data.shortlistLength
                      : 0,
                  onPressed: () => Navigator.pushNamed(
                    context,
                    '/shortlist',
                  ),
                );
              },
            ),
          ]),
      body: StreamBuilder(
        stream: _searchBloc.outSearchState,
        initialData: SearchStateInit(),
        builder: (context, AsyncSnapshot<SearchState> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data is SearchStateInit)
              return _buildInit();
            else if (snapshot.data is SearchStateLoading)
              return _buildLoading();
            else
              return buildList(snapshot.data);
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
        },
      ),
    );
  }

  Widget _buildInit() {
    return Center(
      child: const Text('Make a TMDb movie search'),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildList(SearchStateReady moviesReady) {
    return NotificationListener(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
          controller: _scrollController,
          itemCount: moviesReady.movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: GestureDetector(
                child: MovieCard(
                  movieData: moviesReady.movies[index],
                  onShortlist: (movie) =>
                      _shortlistBloc.inShortlist.add(ShortlistAdd(movie)),
                ),
                onTap: () => Navigator.pushNamed(context, '/movie',
                    arguments: moviesReady.movies[index]),
              ),
            );
          }),
    );
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0)
      _searchBloc.inSearchEvent.add(SearchEvent.next());

    return false;
  }

  @override
  void dispose() {
    _searchBloc.dispose();
    super.dispose();
  }
}
