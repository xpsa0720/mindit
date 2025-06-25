import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/model/prefs_model.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:mindit/user/model/user_information.dart';
import 'package:mindit/user/provider/prefs_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../sqlite/model/base_model.dart';
import '../../task/model/task_state_model.dart';

//
final UserInformationStateNotifierProvider =
    StateNotifierProvider<UserInformationStateNotifier, ModelBase>((ref) {
      final prefs = ref.watch(prefsStateNotifierProvider);
      final taskModel = ref.watch(TaskModelStateNotifierProvider);
      print('왜?');
      return UserInformationStateNotifier(
        taskModel: taskModel,
        prefs: prefs is PrefsModel ? prefs.prefs : null,
      );
    });

class UserInformationStateNotifier extends StateNotifier<ModelBase> {
  final TaskStateModel taskModel;
  final SharedPreferences? prefs;
  UserInformationStateNotifier({required this.taskModel, this.prefs})
    : super(ModelLoading()) {
    InitInfo();
  }

  InitInfo() async {
    try {
      if (prefs != null) {
        final json = await prefs!.getString('userInfo');
        if (json == null) {
          state = ModelError(message: "json null", jsonNull: true);
          return;
        }
        final model = UserInformation.CustomfromJson(jsonDecode(json));
        model.tasks = taskModel;
        state = model;
        print('모델 개수 ${model.tasks.TaskModels}');
        print('이름: ${model.name}');
      } else {
        state = ModelError(message: 'User 정보가 없습니다2');
      }
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
      state = ModelError(message: 'InitInfo 에러 남');
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
      print(e.toString());
      print(s.toString());
      state = ModelError(message: 'InitInfo 에러 남');
    }
  }

  CreateNewUserInfo({String? name}) {
    state = UserInformation(
      name: name ?? "",
      sequenceDay: 0,
      allClearDays: [],
      tasks: taskModel,
    );
    SaveUserInfo();
    InitInfo();
  }
}
