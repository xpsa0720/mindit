import 'package:json_annotation/json_annotation.dart';
import 'package:mindit/sqlite/model/base_model.dart';

class SettingModel extends ModelBase {
  final bool allowScreenOnScreen;
  SettingModel({required this.allowScreenOnScreen});

  factory SettingModel.CustomfromJson(Map<String, dynamic> json) {
    return SettingModel(
      allowScreenOnScreen: (json['allowScreenOnScreen'] as String) == "true",
    );
  }

  Map<String, dynamic> CustomtoJson() => {
    'allowScreenOnScreen': allowScreenOnScreen.toString(),
  };
}
