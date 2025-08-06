import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/user/provider/setting_provider.dart';
import 'package:mindit/user/router/provider/router_provier.dart';
import 'package:mindit/user/view/dash_board_screen.dart';
import 'package:mindit/user/view/lock_screen.dart';
import 'package:screen_on_flutter/screen_on_flutter.dart';
import '../model/setting_model.dart';

final screenServiceProvider =
    StateNotifierProvider<ScreenServiceStateNotifier, ScreenOnFlutter>((ref) {
      final state = ref.watch(setting_provider) as SettingModel;
      final screenService = ref.watch(routerProvider);
      print("screenServiceProvider 호출");
      return ScreenServiceStateNotifier(setting: state, route: screenService);
    });

class ScreenServiceStateNotifier extends StateNotifier<ScreenOnFlutter> {
  final SettingModel setting;
  final GoRouter route;
  ScreenServiceStateNotifier({required this.setting, required this.route})
    : super(
        ScreenOnFlutter(
          routeCallback: (e) {
            print(e);
            if (e == "SCREEN_ON") route.go(LockScreen.routeFullPath);
            // if (e == "LAUNCH_SOURCE") print("LAUNCH_SOURCE");
            if (e == "LAUNCH_SOURCE") route.go(DashBoardScreen.routeFullPath);
          },
        ),
      ) {
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
