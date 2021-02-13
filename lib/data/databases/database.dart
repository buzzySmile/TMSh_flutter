export 'sembast_db.dart';
export 'sqlite_db.dart';

abstract class DbService<T> {
  Future<T> get database;
}
