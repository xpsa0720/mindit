import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../common/data/sqlite.dart';

DatabaseInit() async {
  final path = await getDatabasesPath();
  String dbPath = join(path, 'task.db');
  Database db = await openDatabase(
    dbPath,
    version: db_version,
    onCreate: (database, version) async {
      await database.execute(
        'CREATE TABLE $TABLE_NAME (id INTEGER PRIMARY KEY, title TEXT, dayOfWeekModel TEXT, descriptor TEXT, mainColor TEXT);',
      );
    },
  );
  return db;
}

// int? id;
// final String title;
// final DayOfWeekModel dayOfWeekModel;
// final String descriptor;
// final int mainColor;
