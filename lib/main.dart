import 'package:flutter/material.dart';
import 'package:tmsh_flutter/i18n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';

import 'package:tmsh_flutter/injection.dart';
import 'package:tmsh_flutter/redux/actions/actions.dart';
import 'package:tmsh_flutter/redux/app_state.dart';
import 'package:tmsh_flutter/redux/middleware/middleware.dart';
import 'package:tmsh_flutter/redux/reducers/app_reducer.dart';
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
    middleware: [LoggingMiddleware.printer().call, appMiddlware],
  );

  MyApp({super.key}) {
    store.dispatch(GetShortlistAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', ''), // English, no country code
          Locale('ru', ''), // Russian, no country code
        ],
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blueGrey),
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
      ),
    );
  }
}
