import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/task/model/task_state_model.dart';

import '../../sqlite/model/base_model.dart';
import '../../sqlite/provider/db_provider.dart';
import '../model/param_model.dart';
import '../model/task_model.dart';

final TaskModelProvider = Provider.family<Future<TaskModel>, int>((
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
    TaskStateModel.TaskModels[id] = new_model;
    return new_model;
  } else
    return model;
});

final TaskModelCursorProvider =
    Provider.family<Future<List<TaskModel>>, TaskModel_Praram>((
      ref,
      praram,
    ) async {
      final dbHelper = ref.watch(dbHelperProvider);
      final TaskStateModel = ref.watch(TaskStateModelProvider);

      final model =
          TaskStateModel.TaskModels.where(
            (e) => e.id >= praram.start_id && e.id <= praram.end_id,
          ).toList();

      if (model.isEmpty) {
        print('페이지 네이션 실행');

        final new_models = await dbHelper.QueryCusorTaskModelById(
          end_id: praram.end_id,
          start_id: praram.start_id,
          table: TABLE_NAME,
        );
        for (final i in new_models) {
          TaskStateModel.TaskModels.add(i);
        }
        final model = TaskStateModel.TaskModels.where(
          (e) => e.id >= praram.start_id && e.id <= praram.end_id,
        );
        return new_models;
      } else {
        return model;
      }
    });

final TaskStateModelProvider =
    StateNotifierProvider<TaskStateModelStateNotifier, TaskStateModel>((ref) {
      return TaskStateModelStateNotifier();
    });

class TaskStateModelStateNotifier extends StateNotifier<TaskStateModel> {
  TaskStateModelStateNotifier() : super(TaskStateModel());
}
