import 'package:kiwi/kiwi.dart';
import 'package:http/http.dart' show Client;
import 'package:tmsh_flutter/data/repositories/repository.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';

void injectDependencies() {
  KiwiContainer().registerInstance(Client());
  KiwiContainer().registerInstance(SembastShortlistRepository());
  KiwiContainer().registerFactory((c) => TMDbApiSource(c.resolve<Client>()));
}
