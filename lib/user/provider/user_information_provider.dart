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
      final prefs = ref.watch(prefsStateNotifierProvider) as PrefsModel;
      final taskModel = ref.watch(TaskModelStateNotifierProvider);
      return UserInformationStateNotifier(
        taskModel: taskModel,
        prefs: prefs.prefs,
      );
    });

class UserInformationStateNotifier extends StateNotifier<ModelBase> {
  final TaskStateModel taskModel;
  final SharedPreferences? prefs;
  UserInformationStateNotifier({required this.taskModel, required this.prefs})
    : super(ModelLoading()) {
    InitInfo();
  }

  InitInfo() async {
    try {
      final json = await prefs!.getString('userInfo');
      if (json == null) {
        state = UserInformation(
          name: "",
          sequenceDay: 0,
          allClearDays: [],
          tasks: taskModel,
        );
        SaveUserInfo();
        return;
      }
      final model = UserInformation.CustomfromJson(jsonDecode(json));
      model.tasks = taskModel;
      state = model;
      print('모델 개수 ${model.tasks.TaskModels}');
      print('이름: ${model.name}');
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
      state = ModelError(message: 'InitInfo 에러 남');
    }
  }

  SaveUserInfo() async {
    try {
      if (state is UserInformation == false) return;
      final cp = state as UserInformation;
      final model = cp.CustomtoJson();
      await prefs!.setString('userInfo', jsonEncode(model));
      print(model);
    } catch (e, s) {
      print(e.toString());
      print(s.toString());
      state = ModelError(message: 'SaveUserInfo 에러 남');
    }
  }

  CreateNewUserInfo({String? name}) {
    UserInformation cp = (state as UserInformation);
    state = cp.copyWith(name: name ?? "");
    SaveUserInfo();
  }
}
