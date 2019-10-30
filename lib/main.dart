import 'package:flutter/material.dart';
import 'package:tmsh_flutter/data/storage_service.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';
import 'package:tmsh_flutter/injection.dart';
import 'package:tmsh_flutter/route_generator.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmsh_flutter/shortlist_bloc/bloc.dart';
import 'package:tmsh_flutter/search_bloc/bloc.dart';
import 'package:tmsh_flutter/simple_bloc_delegate.dart';

import 'search_bloc/bloc.dart';

void main() {
  injectDependencies();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final api = kiwi.Container().resolve<TMDbApiSource>();
    final storage = kiwi.Container().resolve<StorageServiceImpl>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<ShortlistBloc>(
          builder: (context) => ShortlistBloc(storage),
        ),
        BlocProvider<SearchBloc>(
          builder: (context) => SearchBloc(api),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      ),
    );
  }
}
