import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_model.dart';

class TaskStateModel extends ModelBase {
  bool isEnd;
  List<TaskModel> TaskModels;

  TaskStateModel({this.isEnd = false, List<TaskModel>? TaskModels})
    : TaskModels = TaskModels ?? [];

  TaskStateModel copyWith({bool? isEnd, List<TaskModel>? TaskModels}) {
    return TaskStateModel(
      isEnd: isEnd ?? this.isEnd,
      TaskModels: TaskModels ?? this.TaskModels,
    );
  }
}
