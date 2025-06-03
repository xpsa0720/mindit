import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_model.dart';
part 'user_information.g.dart';

@JsonSerializable()
class UserInformation extends ModelBase {
  final String name;
  final int sequenceDay;
  final List<DateTime> allClearDays;
  final List<TaskModel> tasks;
  UserInformation({
    required this.name,
    required this.sequenceDay,
    List<DateTime>? allClearDays,
    List<TaskModel>? tasks,
  }) : allClearDays = allClearDays ?? [],
       tasks = tasks ?? [];

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);

  Map<String, dynamic> CustomtoJson() => {
    'name': name,
    'sequenceDay': sequenceDay,
    'tasks': tasks.map((e) => e.toMap()).toList(),
  };

  copyWith({
    String? name,
    int? sequenceDay,
    List<DateTime>? allClearDays,
    List<TaskModel>? tasks,
  }) {
    return UserInformation(
      allClearDays: allClearDays ?? this.allClearDays,
      sequenceDay: sequenceDay ?? this.sequenceDay,
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
    );
  }
}
