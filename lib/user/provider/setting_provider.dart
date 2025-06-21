import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/user/model/setting_model.dart';
import 'package:mindit/user/provider/prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/model/prefs_model.dart';

final setting_provider = StateNotifierProvider<SettingStateNotifier, ModelBase>(
  (ref) {
    final prefs = ref.watch(prefsStateNotifierProvider);

    return SettingStateNotifier(
      prefs: prefs is PrefsModel ? prefs.prefs : null,
    );
  },
);

class SettingStateNotifier extends StateNotifier<ModelBase> {
  final SharedPreferences? prefs;
  SettingStateNotifier({this.prefs}) : super(ModelLoading());

  InitSetting() async {
    try {
      if (prefs != null) {
        final json = await prefs!.getString('setting');
        if (json == null) {
          print("Setting 파일 생성");
          state = SettingModel(allowAlarm: false, allowScreenOnScreen: true);
          await SaveSetting();
          return;
        }
        final model = SettingModel.CustomfromJson(jsonDecode(json!));
        state = model;
        print(model.allowAlarm);
        print(model.allowScreenOnScreen);
      } else {
        state = ModelError(message: 'setting 정보가 없습니다2');
      }
    } catch (e, s) {
      print(e);
      print(s);
      state = ModelError(message: 'InitSetting 에러 남');
    }
  }

  SaveSetting() async {
    try {
      if (prefs != null) {
        if (state is SettingModel == false) return;
        final cp = state as SettingModel;
        final model = cp.CustomtoJson();
        await prefs!.setString('setting', jsonEncode(model));
        print(model);
      } else {
        state = ModelError(message: 'setting 정보가 없습니다2');
      }
    } catch (e, s) {
      print(e);
      print(s);
      state = ModelError(message: 'SaveSetting 에러 남');
    }
  }
}
