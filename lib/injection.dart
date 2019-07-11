import 'package:kiwi/kiwi.dart' show Container;
import 'package:http/http.dart' show Client;
import 'package:tmsh_flutter/bloc/search_bloc.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';

void injectDependencies() {
  Container().registerInstance(Client());
  Container().registerFactory((c) => TMDbApiSource(c.resolve<Client>()));
  Container().registerFactory((c) => SearchBloc(c.resolve<TMDbApiSource>()));
}
