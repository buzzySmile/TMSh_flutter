import 'package:kiwi/kiwi.dart' show Container;
import 'package:http/http.dart' show Client;
import 'package:tmsh_flutter/data/storage_service.dart';
import 'package:tmsh_flutter/data/tmdb_api_source.dart';

void injectDependencies() {
  Container().registerInstance(Client());
  Container().registerInstance(StorageServiceImpl());
  Container().registerFactory((c) => TMDbApiSource(c.resolve<Client>()));
}
