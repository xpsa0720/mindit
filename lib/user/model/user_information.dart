import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/task/model/task_state_model.dart';

class UserInformation extends ModelBase {
  final String name;
  final int sequenceDay;
  final List<DateTime> allClearDays;
  TaskStateModel tasks;

  UserInformation({
    required this.name,
    required this.sequenceDay,
    required this.tasks,
    List<DateTime>? allClearDays,
  }) : allClearDays = allClearDays ?? [];

  factory UserInformation.CustomfromJson(Map<String, dynamic> json) {
    return UserInformation(
      name: json['name'] as String,
      sequenceDay: json['sequenceDay'] as int,
      allClearDays:
          (json['allClearDays'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList(),
      tasks: TaskStateModel(
        TaskModels:
            (json['tasks'] as List<dynamic>?)
                ?.map((e) => TaskModel.fromMap(e as Map<String, dynamic>))
                .toList(),
      ),
    );
  }

  Map<String, dynamic> CustomtoJson() => {
    'name': name,
    'sequenceDay': sequenceDay,
    'allClearDays': allClearDays.map((e) => e.toString()).toList(),
  };

  copyWith({
    String? name,
    int? sequenceDay,
    List<DateTime>? allClearDays,
    TaskStateModel? tasks,
  }) {
    return UserInformation(
      allClearDays: allClearDays ?? this.allClearDays,
      sequenceDay: sequenceDay ?? this.sequenceDay,
      name: name ?? this.name,
      tasks: tasks ?? this.tasks,
    );
  }
}
