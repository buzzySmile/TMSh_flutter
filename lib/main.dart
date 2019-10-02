import 'package:flutter/material.dart';
import 'package:tmsh_flutter/bloc/bloc_provider.dart';
import 'package:tmsh_flutter/bloc/shortlist_bloc.dart';
import 'package:tmsh_flutter/data/storage_service.dart';
import 'package:tmsh_flutter/injection.dart';
import 'package:tmsh_flutter/route_generator.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

void main() {
  injectDependencies();

  runApp(
    BlocProvider<ShortlistBloc>(
      bloc: ShortlistBloc(kiwi.Container().resolve<StorageServiceImpl>()),
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
