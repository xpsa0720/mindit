import 'package:json_annotation/json_annotation.dart';

part 'day_of_week_model.g.dart';

enum DayOfWeek { Mon, Tue, Wed, Thu, Fri, Sat, Sun }

@JsonSerializable()
class DayOfWeekModel {
  final List<DayOfWeek> dayOfWeek;
  DayOfWeekModel({required this.dayOfWeek});

  factory DayOfWeekModel.fromJson(Map<String, dynamic> json) =>
      _$DayOfWeekModelFromJson(json);
}
