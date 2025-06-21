import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/user/provider/setting_provider.dart';
import 'package:screen_on_flutter/screen_on_flutter.dart';

import '../../common/data/data.dart';
import '../../sqlite/model/base_model.dart';
import '../model/setting_model.dart';

final screenServiceProvider = StateProvider<ScreenOnFlutter>((ref) {
  final screenService = ScreenOnFlutter(entryPointName: entryPointName);
  final state = ref.watch(setting_provider);
  if (state is SettingModel) {
    final cp = state as SettingModel;
    if (cp.allowScreenOnScreen)
      screenService.startService();
    else
      screenService.endService();
  }
  return screenService;
});
