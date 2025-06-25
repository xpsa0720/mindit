import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/component/logo_component.dart';
import 'package:mindit/common/view/root_tab.dart';
import 'package:mindit/user/model/user_information.dart';
import 'package:mindit/user/provider/setting_provider.dart';
import 'package:mindit/user/provider/user_information_provider.dart';
import 'package:mindit/user/view/dash_board_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:shared_preferences_android/shared_preferences_android.dart';
import '../../sqlite/provider/db_provider.dart';
import '../../user/provider/prefs_provider.dart';
import '../../user/provider/screen_on_service_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static String get routeFullPath => '/splash';
  static String get routePath => 'splash';
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool InitDBLoading = false;
  bool InitUserLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Init();
  }

  Init() async {
    await InitDB(InitFunction: InitUserInfo);
  }

  InitUserInfo() async {
    await ref.read(prefsStateNotifierProvider.notifier).InitPrefs();
    await ref.read(UserInformationStateNotifierProvider.notifier).InitInfo();
    await ref.read(setting_provider.notifier).InitSetting();
    await ref.read(screenServiceProvider).requestPermission();
    setState(() {
      InitUserLoading = true;
    });
  }

  InitDB({Function? InitFunction}) async {
    await ref.read(dbProvider.notifier).InitDB();
    if (InitFunction != null) {
      InitFunction();
    }
    setState(() {
      InitDBLoading = true;
    });
  }

  checkData() {
    print("CheckData 호출");
    context.go(DashBoardScreen.routeFullPath);
  }

  @override
  Widget build(BuildContext context) {
    if (InitDBLoading && InitUserLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) => checkData());
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            LogoComponent(size: 50),
            SizedBox(height: 20),
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeCap: StrokeCap.round,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
