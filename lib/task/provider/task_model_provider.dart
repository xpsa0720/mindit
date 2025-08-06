import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/sqlite/model/db_helper.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/task/model/task_state_model.dart'
    hide PaginationLoading, PaginationError, PaginationMore;
import 'package:table_calendar/table_calendar.dart';

import '../../common/data/data.dart';
import '../../common/model/pagination_model.dart';
import '../../sqlite/provider/db_provider.dart';

final TaskModelStateNotifierProvider =
    StateNotifierProvider<TaskModelStateNotifier, TaskStateModel>((ref) {
      final dbHelper = ref.watch(dbHelperProvider);
      return TaskModelStateNotifier(DBHelper: dbHelper);
    });

class TaskModelStateNotifier extends StateNotifier<TaskStateModel> {
  final DbHelper DBHelper;
  TaskModelStateNotifier({required this.DBHelper}) : super(TaskStateModel());

  List<TaskModel> toDayTasks() {
    DateTime now = DateTime.now();
    final weekday = All_DayOfWeek_list[now.weekday - 1];

    List<TaskModel> result_list = [];

    for (final i in state.TaskModels) {
      if (i.dayOfWeekModel.dayOfWeek.contains(weekday)) result_list.add(i);
    }
    return result_list;
  }

  addModels(TaskStateModel model) {
    state = state.copyWith(
      TaskModels: [...state.TaskModels, ...model.TaskModels],
    );
  }

  setAllModels(List<TaskModel> models) {
    state = TaskStateModel(isEnd: true, TaskModels: models);
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

  void setEnd(bool isEnd) {
    state = state.copyWith(isEnd: isEnd);
  }

  bool isEnd() {
    return state.isEnd;
  }

  Future<bool> ComplateTask({required String id}) async {
    print("ComplateTask 호출");
    final time = DateTime.now().subtract(Duration(days: 1));
    await DBHelper.ClearTaskModel(
      id: id,
      table: TABLE_NAME,
      time: time.toString(),
    );
    for (final model in state.TaskModels) {
      if (model.id == int.parse(id)) {
        final alreadyExists = model.clearDay.any((d) => isSameDay(d, time));

        if (!alreadyExists) {
          model.clearDay.add(time);
        }
        return true;
      }
    }
    return false;
  }
}

final TaskModelPaginationStateNotifierProvider = StateNotifierProvider<
  TaskModelCursorPaginationStateNotifier,
  Pagination
>((ref) {
  final dbHelper = ref.watch(dbHelperProvider) as DbHelper;
  final taskModel_notifier = ref.watch(TaskModelStateNotifierProvider.notifier);
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
      if (taskModel_notifier.isEnd()) return;
      state = PaginationMore();
      final new_models = await DBHelper.QueryCusorTaskModelById(
        table: TABLE_NAME,
        count: count,
      );
      if (new_models.TaskModels.length < count) taskModel_notifier.setEnd(true);

      if (new_models.TaskModels.length > 0) {
        taskModel_notifier.addModels(new_models);
      } else {
        return;
      }
      state = Pagination();
    } catch (e, s) {
      state = PaginationError(message: e.toString());
      print(s);
    }
  }

  allPagination() async {
    try {
      state = PaginationMore();
      final new_models = await DBHelper.QueryAllTaskModelById(
        table: TABLE_NAME,
      );
      taskModel_notifier.setAllModels(new_models);
      state = Pagination();
    } catch (e, s) {
      state = PaginationError(message: e.toString());
      print(s);
    }
  }
}
