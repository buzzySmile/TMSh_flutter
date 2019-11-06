import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:tmsh_flutter/injection.dart';
import 'package:tmsh_flutter/middleware/middleware.dart';
import 'package:tmsh_flutter/reducers/shortlist_reducer.dart';
import 'package:tmsh_flutter/route_generator.dart';
import 'package:tmsh_flutter/shortlist_state.dart';

void main() {
  injectDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<ShortlistState>(
    shortlistReducer,
    initialState: ShortlistState(),
    middleware: [
      LoggingMiddleware.printer(),
      shortlistMiddlware,
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<ShortlistState>(
      store: this.store,
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
