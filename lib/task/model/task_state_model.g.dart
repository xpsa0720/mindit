// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskStateModel _$TaskStateModelFromJson(Map<String, dynamic> json) =>
    TaskStateModel(
      isEnd: json['isEnd'] as bool? ?? false,
      TaskModels: (json['TaskModels'] as List<dynamic>?)
          ?.map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TaskStateModelToJson(TaskStateModel instance) =>
    <String, dynamic>{
      'isEnd': instance.isEnd,
      'TaskModels': instance.TaskModels,
    };
