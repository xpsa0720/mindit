import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/task/model/day_of_week_model.dart';

import '../../sqlite/model/base_model.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends ModelBase {
  int id;
  final String title;
  final DayOfWeekModel dayOfWeekModel;
  final String descriptor;
  final String mainColor;

  double implementationRate;
  int sequenceDay;
  bool isAlarm;

  TaskModel({
    this.id = 0,
    required this.title,
    required this.dayOfWeekModel,
    required this.descriptor,
    required this.mainColor,
    this.implementationRate = 0,
    this.sequenceDay = 0,
    this.isAlarm = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      dayOfWeekModel: DayOfWeekModel(
        dayOfWeek: DataUtils.StringDataToDayOfWeek(json['dayOfWeekModel']),
      ),
      descriptor: json['descriptor'],
      mainColor: json['mainColor'],
      implementationRate: json['implementationRate'],
      sequenceDay: json['sequenceDay'],
      isAlarm: json['isAlarm'] == '1' ? true : false,
    );
  }

  Map<String, String> toMap() {
    print(mainColor.toString());
    return {
      'title': title,
      'dayOfWeekModel': DataUtils.dayOfWeekToJsonData(dayOfWeekModel),
      'descriptor': descriptor,
      'mainColor': mainColor.toString(),
      'implementationRate': implementationRate.toString(),
      'sequenceDay': sequenceDay.toString(),
      'isAlarm': isAlarm ? '1' : '0',
    };
  }
}
