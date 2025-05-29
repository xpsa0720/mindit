import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/task/model/task_state_model.dart';

import '../../sqlite/model/base_model.dart';
import '../../sqlite/provider/db_provider.dart';
import '../model/task_model.dart';

final TaskModelProvider = Provider.family<Future<TaskModel>, String>((
  ref,
  id,
) async {
  final dbHelper = ref.watch(dbHelperProvider);
  final TaskStateModel = ref.watch(TaskStateModelProvider);
  final model = TaskStateModel.TaskModels[id];
  if (model == null) {
    final new_model = await dbHelper.QueryTaskModelById(
      id: id,
      table: TABLE_NAME,
    );
    TaskStateModel.TaskModels[new_model.id.toString()] = new_model;
    return new_model;
  } else
    return model;
});

final TaskStateModelProvider =
    StateNotifierProvider<TaskStateModelStateNotifier, TaskStateModel>((ref) {
      return TaskStateModelStateNotifier();
    });

class TaskStateModelStateNotifier extends StateNotifier<TaskStateModel> {
  TaskStateModelStateNotifier() : super(TaskStateModel());
}
