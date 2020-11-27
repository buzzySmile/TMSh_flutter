import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmsh_flutter/search_bloc/bloc.dart';
import 'package:tmsh_flutter/ui/search_screen.dart';

class SearchScreenView extends StatelessWidget {
  const SearchScreenView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchBloc>(
      lazy: false,
      create: (_) => SearchBloc(),
      child: SearchScreen(),
    );
  }
}
