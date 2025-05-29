import 'package:sqflite/sqflite.dart';

import '../../task/model/task_model.dart';

class DbHelper {
  final Database db;

  DbHelper({required this.db});

  Future<TaskModel> QueryTaskModelById({
    required String id,
    required String table,
  }) async {
    final result = await db.query(
      table,
      columns: ['id', 'title', 'dayOfWeekModel', 'descriptor', 'mainColor'],
      where: 'id = ?',
      whereArgs: [id],
    );
    return TaskModel.fromMap(result.first);
  }

  Future<List<TaskModel>> QueryAllTaskModelById({required String table}) async {
    final result = await db.query(
      table,
      columns: ['id', 'title', 'dayOfWeekModel', 'descriptor', 'mainColor'],
    );

    List<TaskModel> result_list = [];

    for (final i in result) {
      result_list.add(TaskModel.fromMap(i));
    }

    return result_list;
  }

  InsertTaskModel({required TaskModel model, required String table}) async {
    print(model.mainColor);
    db.insert(table, model.toMap());
  }

  DeletetaskModelById({required String id, required String table}) async {
    db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}
