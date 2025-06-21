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
    InitDB();
    InitUserInfo();
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

  InitDB() async {
    await ref.read(dbProvider.notifier).InitDB();
    setState(() {
      InitDBLoading = true;
    });
  }

  checkData() {
    context.go(DashBoardScreen.routePath);
  }

  @override
  Widget build(BuildContext context) {
    if (InitDBLoading && InitUserLoading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => checkData());
    }
    return Scaffold(
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
