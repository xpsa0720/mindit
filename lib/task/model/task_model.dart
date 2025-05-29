import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/task/model/day_of_week_model.dart';

import '../../sqlite/model/base_model.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends ModelBase {
  int? id;
  final String title;
  final DayOfWeekModel dayOfWeekModel;
  final String descriptor;
  final String mainColor;

  double implementationRate = 0;
  int sequenceDay = 0;

  TaskModel({
    this.id,
    required this.title,
    required this.dayOfWeekModel,
    required this.descriptor,
    required this.mainColor,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    print('"123" ${json['mainColor']}');
    return TaskModel(
      id: json['id'],
      title: json['title'],
      dayOfWeekModel: DayOfWeekModel(
        dayOfWeek: DataUtils.StringDataToDayOfWeek(json['dayOfWeekModel']),
      ),
      descriptor: json['descriptor'],
      mainColor: json['mainColor'],
    );
  }

  Map<String, String> toMap() {
    print(mainColor.toString());
    return {
      'title': title,
      'dayOfWeekModel': DataUtils.dayOfWeekToJsonData(dayOfWeekModel),
      'descriptor': descriptor,
      'mainColor': mainColor.toString(),
    };
  }
}
