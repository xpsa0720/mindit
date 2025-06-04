import 'package:sqflite/sqflite.dart';

import '../../task/model/task_model.dart';
import '../../task/model/task_state_model.dart';

class DbHelper {
  final Database db;
  int start_id = 0;
  int end_id = 0;

  DbHelper({required this.db});
  Future<TaskModel> QueryTaskModelById({
    required int id,
    required String table,
  }) async {
    final result = await db.query(
      table,
      columns: [
        'id',
        'title',
        'dayOfWeekModel',
        'descriptor',
        'mainColor',
        'implementationRate',
        'sequenceDay',
        'isAlarm',
      ],
      where: 'id = ?',
      whereArgs: [id],
    );
    return TaskModel.fromMap(result.first);
  }

  Future<TaskStateModel> QueryCusorTaskModelById({
    required String table,
    int count = 20,
  }) async {
    if (end_id == 0 && start_id == 0) end_id += count;
    final result = await db.query(
      table,
      columns: [
        'id',
        'title',
        'dayOfWeekModel',
        'descriptor',
        'mainColor',
        'implementationRate',
        'sequenceDay',
        'isAlarm',
      ],
      where: 'id >= ? AND id <= ?',
      whereArgs: [start_id, end_id],
      limit: count,
    );
    final List<TaskModel> return_result = [];
    start_id += count;
    end_id += count;
    for (final i in result) {
      print(i['id'].runtimeType);
      return_result.add(TaskModel.fromMap(i));
    }

    return TaskStateModel(TaskModels: return_result);
  }

  Future<List<TaskModel>> QueryAllTaskModelById({required String table}) async {
    final result = await db.query(
      table,
      columns: [
        'id',
        'title',
        'dayOfWeekModel',
        'descriptor',
        'mainColor',
        'implementationRate',
        'sequenceDay',
        'isAlarm',
      ],
    );

    List<TaskModel> result_list = [];

    for (final i in result) {
      result_list.add(TaskModel.fromMap(i));
    }

    return result_list;
  }

  InsertTaskModel({required TaskModel model, required String table}) async {
    await db.insert(table, model.Sqlite_toMap());
    final result = await db.query(
      table,
      columns: ['id'],
      orderBy: 'id DESC',
      limit: 1,
    );
    return result.first['id'];
  }

  DeletetaskModelById({required String id, required String table}) async {
    await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
