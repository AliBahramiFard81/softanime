import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sqflite/sqflite.dart';

class MainDatabase {
  static final MainDatabase mainDatabase = MainDatabase();
  late Database _database;

  Future<Database> get database async {
    _database = await openDb();
    return _database;
  }

  Future<Database> openDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'SoftAnime.db');

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: initDb,
      onUpgrade: onUpgrade,
    );
    return database;
  }

  void onUpgrade(
    Database database,
    int oldVersion,
    int newVersion,
  ) {
    if (newVersion > oldVersion) {}
  }

  void initDb(Database database, int version) async {
    await database.execute("CREATE TABLE searchHistory ("
        "id INTEGER PRIMARY KEY, "
        "title TEXT, "
        "myid TEXT, "
        "type TEXT "
        ")");
  }
}
