import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/common/component/button_component.dart';
import 'package:mindit/user/provider/setting_provider.dart';
import 'package:mindit/user/provider/user_information_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../common/component/text_component.dart';
import '../../common/component/text_filed_component.dart';
import '../model/setting_model.dart';
import '../model/user_information.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({super.key});
  static String get routeFullPath => '/setting';

  static String get routePath => 'setting';

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  bool LockScreenButton = false;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(UserInformationStateNotifierProvider);
    print("셋팅 호출: $state");
    if (state is UserInformation) {
      final cp = state as UserInformation;
      print(cp.name);
      textEditingController.text = cp.name;
    }
    return SizedBox(
      height: 1500,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          BoxComponent(
            width: double.infinity,
            height: 600,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(children: [TextComponent(text: '이름')]),
                  SizedBox(height: 10),
                  textWidget(),
                  SizedBox(height: 15),

                  ScreenOnServiceWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  textWidget() {
    return Row(
      children: [
        SizedBox(
          width: 300,
          child: TextFiledComponent(
            textEditingController: textEditingController,
          ),
        ),
      ],
    );
  }

  ScreenOnServiceWidget() {
    final state = ref.watch(setting_provider) as SettingModel;
    if (state.allowScreenOnScreen) LockScreenButton = true;
    return Row(
      children: [
        TextComponent(text: "잠금 화면 표시"),
        ButtonComponent(
          enableColor: LockScreenButton,
          callback: () {},
          text: "예",
        ),
        ButtonComponent(
          enableColor: !LockScreenButton,
          callback: () {},
          text: "아니요",
        ),
      ],
    );
  }
}
