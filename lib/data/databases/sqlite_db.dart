import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import './database.dart';

class SQLiteDb implements DbService<sqlite.Database> {
  static sqlite.Database _db;

  static final SQLiteDb _instance = SQLiteDb._internal();

  SQLiteDb._internal();

  factory SQLiteDb() => _instance;

  @override
  Future<sqlite.Database> get database async {
    if (_db == null) _db = await _openDatabase();

    return _db;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(appDocumentDir.path, 'sqlite_shortlist.db');
    final database =
        await sqlite.openDatabase(dbPath, version: 1, onCreate: _onCreate);

    print("SQLITE DB: $dbPath opened");
    return database;
  }

  void _onCreate(sqlite.Database db, int version) async {
    await db.execute('''CREATE TABLE Movies(id STRING PRIMARY KEY, 
        title TEXT, poster_path TEXT, 
        overview TEXT, 
        favored BIT)''');

    print("SQLITE DB: TABLE Movies was Created!");
  }

  Future closeDatabase() async {
    var dbClient = await database;
    dbClient.close();
  }
}
