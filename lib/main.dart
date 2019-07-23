import 'package:flutter/material.dart';
import 'package:tmsh_flutter/bloc/bloc_provider.dart';
import 'package:tmsh_flutter/bloc/shortlist_bloc.dart';
import 'package:tmsh_flutter/injection.dart';
import 'package:tmsh_flutter/route_generator.dart';

void main() {
  injectDependencies();

  runApp(
    BlocProvider<ShortlistBloc>(
      bloc: ShortlistBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
    );
  }
}
