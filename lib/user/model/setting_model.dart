import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/sqlite/model/base_model.dart';

class SettingModel extends ModelBase {
  final bool allowAlarm;
  final bool allowScreenOnScreen;
  SettingModel({required this.allowAlarm, required this.allowScreenOnScreen});

  factory SettingModel.CustomfromJson(Map<String, dynamic> json) {
    return SettingModel(
      allowAlarm: (json['allowAlarm'] as String) == "true",
      allowScreenOnScreen: (json['allowScreenOnScreen'] as String) == "true",
    );
  }

  Map<String, dynamic> CustomtoJson() => {
    'allowAlarm': allowAlarm.toString(),
    'allowScreenOnScreen': allowScreenOnScreen.toString(),
  };
}
