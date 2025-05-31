import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/task/model/task_state_model.dart';

import '../../sqlite/model/base_model.dart';
import '../../sqlite/provider/db_provider.dart';
import '../model/param_model.dart';
import '../model/task_model.dart';
import '../util/dummy_data.dart';

// final TaskModelProvider = Provider.family<Future<TaskModel>, int>((
//   ref,
//   id,
// ) async {
//   final dbHelper = ref.watch(dbHelperProvider);
//   final TaskStateModel = ref.watch(TaskStateModelProvider);
//   final model = TaskStateModel.TaskModels[id];
//   if (model == null) {
//     final new_model = await dbHelper.QueryTaskModelById(
//       id: id,
//       table: TABLE_NAME,
//     );
//     TaskStateModel.TaskModels[id] = new_model;
//     return new_model;
//   } else
//     return model;
// });

final TaskModelCursorProvider =
    Provider.family<Future<TaskStateModel>, TaskModel_Praram>((
      ref,
      praram,
    ) async {
      final dbHelper = ref.watch(dbHelperProvider);
      final StateModel = ref.watch(TaskStateModelProvider);

      final model_data =
          StateModel.TaskModels.where(
            (e) => e.id >= praram.start_id && e.id <= praram.end_id,
          ).toList();

      if (model_data.isEmpty) {
        final new_models = await dbHelper.QueryCusorTaskModelById(
          end_id: praram.end_id,
          start_id: praram.start_id,
          table: TABLE_NAME,
        );

        StateModel.TaskModels.addAll(new_models.TaskModels);

        StateModel.TaskModels.sort((a, b) => a.id.compareTo(b.id));
        if (new_models.TaskModels.length > 0 &&
            new_models.TaskModels.length < praram.length) {
          print('더미 추가');
          StateModel.TaskModels.add(dummyModel);
        }
        return new_models;
      } else {
        return TaskStateModel(TaskModels: model_data);
      }
    });

final TaskStateModelProvider =
    StateNotifierProvider<TaskStateModelStateNotifier, TaskStateModel>((ref) {
      return TaskStateModelStateNotifier();
    });

class TaskStateModelStateNotifier extends StateNotifier<TaskStateModel> {
  TaskStateModelStateNotifier() : super(TaskStateModel());

  addTaskModelData(TaskModel model) {
    state.TaskModels.add(model);
    // List.generate(state.TaskModels.length, (index) {
    //   print('${state.TaskModels[index].id}');
    // });
    state.TaskModels.sort((a, b) => a.id.compareTo(b.id));
  }

  addTaskModeslData(List<TaskModel> model) {
    state.TaskModels.addAll(model);
    state.TaskModels.sort((a, b) => a.id.compareTo(b.id));
  }
}
