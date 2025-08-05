import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/user/provider/setting_provider.dart';
import 'package:screen_on_flutter/screen_on_flutter.dart';
import '../model/setting_model.dart';

final screenServiceProvider =
    StateNotifierProvider<ScreenServiceStateNotifier, ScreenOnFlutter>((ref) {
      final state = ref.watch(setting_provider) as SettingModel;
      print("screenServiceProvider 호출");
      return ScreenServiceStateNotifier(setting: state);
    });

class ScreenServiceStateNotifier extends StateNotifier<ScreenOnFlutter> {
  final SettingModel setting;
  ScreenServiceStateNotifier({required this.setting})
    : super(ScreenOnFlutter()) {
    updateSetting();
  }

  updateSetting() async {
    if (setting.allowScreenOnScreen) {
      print("서비스 시작");
      await state.startService();
    } else {
      print("서비스 끝");
      await state.endService();
    }
  }
}
