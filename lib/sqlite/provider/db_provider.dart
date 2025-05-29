import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/data/sqlite.dart';
import '../model/base_model.dart';
import '../model/db_helper.dart';
import '../model/db_model.dart';

final dbHelperProvider = Provider<DbHelper>((ref) {
  final db = ref.watch(dbProvider);
  if (db is ModelLoading) {
    print('InitDB 실행 안함 나 터질게 ㅅㄱ');
    throw Error();
  }
  final cp = db as db_model;
  final dbHelper = DbHelper(db: cp.db);
  return dbHelper;
});

final dbProvider = StateNotifierProvider<dbStateNotifier, ModelBase>((ref) {
  return dbStateNotifier();
});

class dbStateNotifier extends StateNotifier<ModelBase> {
  dbStateNotifier() : super(ModelLoading());

  InitDB() async {
    final path = await getDatabasesPath();
    String dbPath = join(path, 'task.db');
    Database db = await openDatabase(
      dbPath,
      version: db_version,
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE TASKTABLE (id INTEGER PRIMARY KEY, title TEXT, dayOfWeekModel TEXT, descriptor TEXT, mainColor TEXT, implementationRate REAL, sequenceDay INTEGER, isAlarm INTEGER);',
        );
      },
    );
    state = db_model(db: db);
  }
}

// db_model
// int? id;
// final String title;
// final DayOfWeekModel dayOfWeekModel;
// final String descriptor;
// final String mainColor;
//
// double implementationRate = 0;
// int sequenceDay = 0;
