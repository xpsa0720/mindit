import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_model.dart';

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

  factory TaskStateModel.fromJson(Map<String, dynamic> json) =>
      _$TaskStateModelFromJson(json);
}
