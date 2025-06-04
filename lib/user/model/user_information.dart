import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_model.dart';
part 'user_information.g.dart';

@JsonSerializable()
class UserInformation extends ModelBase {
  final String name;
  final int sequenceDay;
  final List<DateTime> allClearDays;
  UserInformation({
    required this.name,
    required this.sequenceDay,
    List<DateTime>? allClearDays,
    List<TaskModel>? tasks,
  }) : allClearDays = allClearDays ?? [];

  factory UserInformation.fromJson(Map<String, dynamic> json) =>
      _$UserInformationFromJson(json);

  factory UserInformation.CustomfromJson(Map<String, dynamic> json) {
    return UserInformation(
      name: json['name'] as String,
      sequenceDay: (json['sequenceDay'] as num).toInt(),
      allClearDays:
          (json['allClearDays'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList(),
      tasks:
          (json['tasks'] as List<dynamic>?)
              ?.map((e) => TaskModel.fromMap(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> CustomtoJson() => {
    'name': name,
    'sequenceDay': sequenceDay,
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
    );
  }
}
