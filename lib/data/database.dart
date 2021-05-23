import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();

  static Database? _database;

  AppDatabase._();

  static AppDatabase get instance => _singleton;

  Future<Database> get database async => _database ??= await _openDatabase();

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, 'shortlist.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);

    print("DB: $dbPath opened");

    return database;
  }
}
