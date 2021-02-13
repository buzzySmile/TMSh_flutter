import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast/sembast_io.dart';
import './database.dart';

class SembastDb implements DbService<sembast.Database> {
  static final SembastDb _instance = SembastDb._();

  static sembast.Database _database;

  SembastDb._();

  static SembastDb get instance => _instance;

  @override
  Future<sembast.Database> get database async {
    if (_database == null) _database = await _openDatabase();

    return _database;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'sembast_shortlist.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);

    print("SEMBAST DB: $dbPath opened");

    return database;
  }
}
