import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tmsh_flutter/shortlist_state.dart';
import 'package:tmsh_flutter/ui/widget/count_button.dart';

class ShortlistButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<ShortlistState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return CountButton(
          child: const Icon(Icons.star),
          onPressed: () => Navigator.pushNamed(
            context,
            '/shortlist',
          ),
          count: vm.numMovies,
        );
      },
    );
  }
}

class _ViewModel {
  final int numMovies;

  _ViewModel({@required this.numMovies});

  static _ViewModel fromStore(Store<ShortlistState> store) {
    return _ViewModel(
      numMovies: store.state.movies.length,
    );
  }

  @override
  String toString() {
    return '_ViewModel{numMovies: $numMovies}';
  }
}
