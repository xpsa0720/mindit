// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_of_week_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayOfWeekModel _$DayOfWeekModelFromJson(Map<String, dynamic> json) =>
    DayOfWeekModel(
      dayOfWeek: (json['dayOfWeek'] as List<dynamic>)
          .map((e) => $enumDecode(_$DayOfWeekEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$DayOfWeekModelToJson(
  DayOfWeekModel instance,
) => <String, dynamic>{
  'dayOfWeek': instance.dayOfWeek.map((e) => _$DayOfWeekEnumMap[e]!).toList(),
};

const _$DayOfWeekEnumMap = {
  DayOfWeek.Mon: 'Mon',
  DayOfWeek.Tue: 'Tue',
  DayOfWeek.Wed: 'Wed',
  DayOfWeek.Thu: 'Thu',
  DayOfWeek.Fri: 'Fri',
  DayOfWeek.Sat: 'Sat',
  DayOfWeek.Sun: 'Sun',
};
