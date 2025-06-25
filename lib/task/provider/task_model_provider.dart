import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/sqlite/model/db_helper.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/task/model/task_state_model.dart'
    hide PaginationLoading, PaginationError, PaginationMore;

import '../../common/model/pagination_model.dart';
import '../../common/util/data_util.dart';
import '../../sqlite/model/base_model.dart';
import '../../sqlite/provider/db_provider.dart';
import '../model/day_of_week_model.dart';
import '../util/dummy_data.dart';

final TaskModelStateNotifierProvider =
    StateNotifierProvider<TaskModelStateNotifier, TaskStateModel>((ref) {
      final dbHelper = ref.watch(dbHelperProvider);
      return TaskModelStateNotifier(DBHelper: dbHelper);
    });

class TaskModelStateNotifier extends StateNotifier<TaskStateModel> {
  final DbHelper DBHelper;
  TaskModelStateNotifier({required this.DBHelper}) : super(TaskStateModel());

  addModels(TaskStateModel model) {
    state = state.copyWith(
      TaskModels: [...state.TaskModels, ...model.TaskModels],
    );
  }

  addlist(TaskModel model) async {
    final id = await DBHelper.InsertTaskModel(model: model, table: TABLE_NAME);
    // final id = await DBHelper.InsertTaskModel(
    //   model: dummyModel,
    //   table: TABLE_NAME,
    // );
    model.id = id;
    state = state.copyWith(TaskModels: [...state.TaskModels, model]);

    return id;
  }

  deleteModel(TaskModel model) async {
    final id = await DBHelper.DeletetaskModelById(
      id: model.id.toString(),
      table: TABLE_NAME,
    );
    final cp = state.TaskModels;
    cp.removeWhere((e) => e.id == model.id);
    state = state.copyWith(TaskModels: cp);

    return id;
  }

  isEnd(bool isEnd) {
    state = state.copyWith(isEnd: isEnd);
  }

  Complate() {}
}

final TaskModelPaginationStateNotifierProvider = StateNotifierProvider<
  TaskModelCursorPaginationStateNotifier,
  Pagination
>((ref) {
  final dbHelper = ref.watch(dbHelperProvider);
  final taskModel_notifier = ref.watch(TaskModelStateNotifierProvider.notifier);
  print('state 초기화');
  return TaskModelCursorPaginationStateNotifier(
    DBHelper: dbHelper,
    taskModel_notifier: taskModel_notifier,
  );
});

class TaskModelCursorPaginationStateNotifier extends StateNotifier<Pagination> {
  final DbHelper DBHelper;
  final TaskModelStateNotifier taskModel_notifier;
  TaskModelCursorPaginationStateNotifier({
    required this.DBHelper,
    required this.taskModel_notifier,
  }) : super(PaginationLoading()) {
    paginate();
  }

  @override
  paginate({int count = 20}) async {
    final isError = state is PaginationError;
    final isPaginationMore = state is PaginationMore;
    if ((isError) || isPaginationMore) {
      return;
    }
    try {
      state = PaginationMore();
      await Future.delayed(Duration(seconds: 2));
      final new_models = await DBHelper.QueryCusorTaskModelById(
        table: TABLE_NAME,
        count: count,
      );
      if (new_models.TaskModels.length < count) taskModel_notifier.isEnd(true);

      if (new_models.TaskModels.length > 0) {
        taskModel_notifier.addModels(new_models);
      }
      state = Pagination();
    } catch (e, s) {
      state = PaginationError(message: e.toString());
      print(s);
    }
  }
}
