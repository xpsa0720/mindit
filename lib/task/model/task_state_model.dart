import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_model.dart';

import '../../common/data/data.dart';

part 'task_state_model.g.dart';

@JsonSerializable()
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

  List<TaskModel> toDayTasks() {
    DateTime now = DateTime.now();
    final weekday = All_DayOfWeek_list[now.weekday - 1];

    List<TaskModel> result_list = [];

    for (final i in TaskModels) {
      if (i.dayOfWeekModel.dayOfWeek.contains(weekday)) result_list.add(i);
    }
    return result_list;
  }

  factory TaskStateModel.fromJson(Map<String, dynamic> json) =>
      _$TaskStateModelFromJson(json);
}
