import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tmsh_flutter/redux/actions/actions.dart';
import 'package:tmsh_flutter/redux/app_state.dart';
import 'package:tmsh_flutter/redux/middleware/middleware.dart';
import 'package:tmsh_flutter/redux/reducers/app_reducer.dart';
import 'package:tmsh_flutter/injection.dart';
import 'package:tmsh_flutter/route_generator.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  injectDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState(),
    middleware: [
      LoggingMiddleware.printer(),
      appMiddlware,
    ],
  );

  MyApp() {
    store.dispatch(GetShortlistAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
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
