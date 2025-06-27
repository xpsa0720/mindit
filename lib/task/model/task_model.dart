import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/sqlite/model/db_helper.dart';
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

  DateTime createTime;
  List<DateTime> clearDay;
  double implementationRate;
  int sequenceDay;

  TaskModel({
    this.id = -1,
    required this.title,
    required this.dayOfWeekModel,
    required this.descriptor,
    required this.mainColor,
    this.implementationRate = 0,
    this.sequenceDay = 0,
    List<DateTime>? clearDay,
    DateTime? createTime,
  }) : clearDay = clearDay ?? [],
       createTime = createTime ?? DateTime.now();

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.fromMap(Map<String, dynamic> json) {
    List<DateTime> clearDay = [];
    if (json['id'].runtimeType == String) {
      json['id'] = int.parse(json['id']);
    }
    if (json['implementationRate'].runtimeType == String) {
      json['implementationRate'] = double.parse(json['implementationRate']);
    }
    if (json['sequenceDay'].runtimeType == String) {
      json['sequenceDay'] = int.parse(json['sequenceDay']);
    }
    if (json['clearDay'].toString().isNotEmpty) {
      clearDay =
          json['clearDay']
              .toString()
              .split(';')
              .map((e) => DateTime.parse(e))
              .toList();
    }
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
      clearDay: clearDay,
      createTime: DateTime.parse(json['createTime']),
    );
  }

  Map<String, String> Sqlite_toMap() {
    return {
      'title': title,
      'dayOfWeekModel': DataUtils.dayOfWeekToJsonData(dayOfWeekModel),
      'descriptor': descriptor,
      'mainColor': mainColor.toString(),
      'implementationRate': implementationRate.toString(),
      'sequenceDay': sequenceDay.toString(),
      'clearDay': clearDay.map((e) => e.toString()).join(';'),
      'createTime': createTime.toString(),
    };
  }

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);

  Clear() {
    clearDay.add(DateTime.now());
  }
}
