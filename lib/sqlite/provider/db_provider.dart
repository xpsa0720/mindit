import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../common/data/sqlite.dart';
import '../model/base_model.dart';
import '../model/db_helper.dart';
import '../model/db_model.dart';

final dbHelperProvider = Provider<DbHelper>((ref) {
  final db = ref.watch(dbProvider) as db_model;
  return DbHelper(db: db.db);
});

final dbProvider = StateNotifierProvider<dbStateNotifier, ModelBase>((ref) {
  return dbStateNotifier();
});

class dbStateNotifier extends StateNotifier<ModelBase> {
  dbStateNotifier() : super(ModelLoading());

  InitDB() async {
    if (state is! db_model) {
      final path = await getDatabasesPath();
      String dbPath = join(path, 'task.db');
      Database db = await openDatabase(
        dbPath,
        version: db_version,
        onCreate: (database, version) async {
          await database.execute(
            'CREATE TABLE TASKTABLE (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, dayOfWeekModel TEXT, descriptor TEXT, mainColor TEXT, implementationRate REAL, sequenceDay INTEGER, clearDay TEXT, createTime TEXT);',
          );
        },
      );
      state = db_model(db: db);
    }
  }
}
