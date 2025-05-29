import 'package:sqflite/sqflite.dart';

import '../../task/model/task_model.dart';

class DbHelper {
  final Database db;

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

  Future<List<TaskModel>> QueryCusorTaskModelById({
    required String table,
    required int start_id,
    required int end_id,
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
      where: 'id >= ? AND id <= ?',
      whereArgs: [start_id, end_id],
    );
    List<TaskModel> result_list = [];

    for (final i in result) {
      result_list.add(TaskModel.fromMap(i));
    }

    return result_list;
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
    db.insert(table, model.toMap());
  }

  DeletetaskModelById({required String id, required String table}) async {
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
