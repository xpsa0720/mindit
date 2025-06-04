// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_information.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInformation _$UserInformationFromJson(Map<String, dynamic> json) =>
    UserInformation(
      name: json['name'] as String,
      sequenceDay: (json['sequenceDay'] as num).toInt(),
      allClearDays: (json['allClearDays'] as List<dynamic>?)
          ?.map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$UserInformationToJson(UserInformation instance) =>
    <String, dynamic>{
      'name': instance.name,
      'sequenceDay': instance.sequenceDay,
      'allClearDays': instance.allClearDays
          .map((e) => e.toIso8601String())
          .toList(),
    };
