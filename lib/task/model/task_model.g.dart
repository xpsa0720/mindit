// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
  id: (json['id'] as num?)?.toInt() ?? -1,
  title: json['title'] as String,
  dayOfWeekModel: DayOfWeekModel.fromJson(
    json['dayOfWeekModel'] as Map<String, dynamic>,
  ),
  descriptor: json['descriptor'] as String,
  mainColor: json['mainColor'] as String,
  implementationRate: (json['implementationRate'] as num?)?.toDouble() ?? 0,
  sequenceDay: (json['sequenceDay'] as num?)?.toInt() ?? 0,
  isAlarm: json['isAlarm'] as bool? ?? false,
  clearDay: (json['clearDay'] as List<dynamic>?)
      ?.map((e) => DateTime.parse(e as String))
      .toList(),
);

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'dayOfWeekModel': instance.dayOfWeekModel,
  'descriptor': instance.descriptor,
  'mainColor': instance.mainColor,
  'clearDay': instance.clearDay.map((e) => e.toIso8601String()).toList(),
  'implementationRate': instance.implementationRate,
  'sequenceDay': instance.sequenceDay,
  'isAlarm': instance.isAlarm,
};
