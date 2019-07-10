import 'package:flutter/material.dart';
import 'package:tmsh_flutter/ui/widget/favorite_button.dart';
import 'package:tmsh_flutter/ui/widget/search_field.dart';
import 'package:tmsh_flutter/bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  final String title;

  SearchScreen({Key key, this.title}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc _searchBloc = SearchBloc();
  final ScrollController _scrollController = ScrollController();

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
            // Icon that gives direct access to the favorites
            // displays "real-time" number of favorites
            FavoriteButton(child: const Icon(Icons.star)),
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
            return Text(snapshot.error.toString());
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
      child: GridView.builder(
          controller: _scrollController,
          itemCount: moviesReady.movies.length,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
              child: InkResponse(
                enableFeedback: true,
                child: Image.network(
                  moviesReady.movies[index].posterPath,
                  fit: BoxFit.cover,
                ),
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
