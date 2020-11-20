import 'package:flutter/material.dart';
import 'package:tmsh_flutter/data/models/tmdb_movie_card.dart';
import 'package:tmsh_flutter/ui/widget/favorite_button.dart';
import 'package:tmsh_flutter/ui/widget/movie_card.dart';
import 'package:tmsh_flutter/ui/widget/search_field.dart';

class SearchScreen extends StatefulWidget {
  final List<TMDbMovieCard> searchResult;
  final ValueChanged<String> onSearch;

  SearchScreen({
    Key key,
    this.searchResult,
    this.onSearch,
  }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
                onChanged: widget.onSearch,
              ),
            ),
          ),
          actions: <Widget>[
            FavoriteButton(
              icon: const Icon(Icons.star),
            ),
          ]),
      body: Center(
        child: const Text('Make a TMDb movie search'),
      ),
      // BlocBuilder<SearchBloc, SearchState>(
      //   builder: (context, SearchState state) {
      //     if (state is SearchStateInit) return _buildInit();

      //     if (state is SearchStateLoading) return _buildLoading();
      //     if (state is SearchStateReady) return buildList(context, state);
      //     return Center(
      //       child: Text('Something went wrong!'),
      //     );
      //   },
      // ),
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

  // Widget buildList(BuildContext context, SearchStateReady moviesReady) {
  //   return NotificationListener(
  //     onNotification: (onNotify) =>
  //         _handleScrollNotification(context, onNotify),
  //     child: ListView.builder(
  //         controller: _scrollController,
  //         itemCount: moviesReady.movies.length,
  //         itemBuilder: (BuildContext context, int index) {
  //           return Card(
  //             child: GestureDetector(
  //               child: MovieCard(
  //                 movieData: moviesReady.movies[index],
  //                 onShortlist: (movie) =>
  //                     BlocProvider.of<ShortlistBloc>(context).add(
  //                   ShortlistAdd(movie),
  //                 ),
  //               ),
  //               onTap: () => Navigator.pushNamed(context, '/movie',
  //                   arguments: moviesReady.movies[index]),
  //             ),
  //           );
  //         }),
  //   );
  // }

  // bool _handleScrollNotification(
  //     BuildContext context, ScrollNotification notification) {
  //   if (notification is ScrollEndNotification &&
  //       _scrollController.position.extentAfter == 0)
  //     BlocProvider.of<SearchBloc>(context).add(SearchEvent.next());

  //   return false;
  // }
}
