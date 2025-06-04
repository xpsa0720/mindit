import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/model/prefs_model.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/user/model/user_information.dart';
import 'package:mindit/user/provider/prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../sqlite/model/base_model.dart';

//
final UserInformationStateNotifierProvider =
    StateNotifierProvider<UserInformationStateNotifier, ModelBase>((ref) {
      final prefs = ref.watch(prefsStateNotifierProvider);
      return UserInformationStateNotifier(
        prefs: prefs is PrefsModel ? prefs.prefs : null,
      );
    });

class UserInformationStateNotifier extends StateNotifier<ModelBase> {
  final SharedPreferences? prefs;
  UserInformationStateNotifier({this.prefs}) : super(ModelLoading());

  InitInfo() async {
    try {
      if (prefs != null) {
        final json = await prefs!.getString('userInfo');
        if (json == null) {
          state = ModelError(message: 'User 정보가 없습니다1');
          print('응애');
        }
        final model = UserInformation.CustomfromJson(jsonDecode(json!));
        // print(model.tasks[0].dayOfWeekModel.dayOfWeek.length);
        state = model;
      } else {
        state = ModelError(message: 'User 정보가 없습니다2');
      }
    } catch (e, s) {
      print(e);
      print(s);
      state = ModelError(message: '에러 남');
    }
  }

  SaveUserInfo() async {
    try {
      if (prefs != null) {
        if (state is UserInformation == false) return;
        final cp = state as UserInformation;
        final model = cp.CustomtoJson();
        await prefs!.setString('userInfo', jsonEncode(model));
        print(model);
      } else {
        state = ModelError(message: 'User 정보가 없습니다2');
      }
    } catch (e, s) {
      print(e);
      print(s);
      state = ModelError(message: '에러 남');
    }
  }
}
