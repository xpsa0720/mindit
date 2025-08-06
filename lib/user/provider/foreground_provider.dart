import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:mindit/user/foreground/util.dart';
import 'package:mindit/user/provider/user_information_provider.dart';
import '../../task/model/task_model.dart';

final ForegroundServiceProvider =
    StateNotifierProvider<ForegroundStateNotifier, ModelBase>((ref) {
      final user_notifier = ref.watch(
        UserInformationStateNotifierProvider.notifier,
      );
      final task_notifier = ref.watch(TaskModelStateNotifierProvider.notifier);
      final toDayTask = ref.watch(TaskModelStateNotifierProvider).toDayTasks();
      return ForegroundStateNotifier(
        taskNotifier: task_notifier,
        userNotifier: user_notifier,
        models: toDayTask,
      );
    });

class ForegroundStateNotifier extends StateNotifier<ModelBase> {
  final List<TaskModel> models;
  final UserInformationStateNotifier userNotifier;
  final TaskModelStateNotifier taskNotifier;
  ForegroundStateNotifier({
    required this.models,
    required this.userNotifier,
    required this.taskNotifier,
  }) : super(ModelLoading()) {
    Update();
  }

  Update() async {
    final TodayFile = await DataUtils.getTodayTempFile();
    await UpdateTask();
    final data = await getTaskJson(TodayFile);
    if (!mounted) return;
    state = ForegroundService(stateTask: data);
  }

  Future<void> UpdateTask() async {
    final TodayFile = await DataUtils.getTodayTempFile();
    final json = await getTaskJson(TodayFile);
    final List<int> list = [for (final i in json.keys) int.parse(i)];
    final different_models = models.where((e) => !list.contains(e.id)).toList();
    print(different_models);
    json.addAll({for (final i in different_models) i.id.toString(): false});

    final modelIds = models.map((e) => e.id).toSet();
    final jsonIds = json.keys.map(int.parse).toSet();

    final jsonOnlyIds = jsonIds.difference(modelIds);
    json.removeWhere((k, v) => jsonOnlyIds.contains(int.parse(k)));
    print(jsonOnlyIds);

    await TodayFile.writeAsString('', flush: true);
    await TodayFile.writeAsString(jsonEncode(json), flush: true);
  }

  deleteTask(TaskModel model) async {
    final TodayFile = await DataUtils.getTodayTempFile();
    final taskJson = await getTaskJson(TodayFile);
    print('삭제:${model.id.toString()}, ${model.title}');
    taskJson.remove(model.id.toString());
    print(jsonEncode(taskJson));
    await TodayFile.writeAsString(
      jsonEncode(taskJson),
      flush: true,
      mode: FileMode.write,
    );
  }

  complateTask(TaskModel model) async {
    final TodayFile = await DataUtils.getTodayTempFile();
    final taskJson = await getTaskJson(TodayFile);
    taskJson[model.id.toString()] = true;
    print(taskJson);
    state = ForegroundService(stateTask: taskJson);

    await TodayFile.writeAsString(jsonEncode(taskJson)); // 저장
  }

  cancelTask(TaskModel model) async {
    final TodayFile = await DataUtils.getTodayTempFile();
    final taskJson = await getTaskJson(TodayFile);
    taskJson[model.id.toString()] = false;
    print(taskJson);
    state = ForegroundService(stateTask: taskJson);
    await TodayFile.writeAsString(jsonEncode(taskJson)); // 저장
  }

  complateToday() async {
    await Update();
    final TodayFile = await DataUtils.getTodayTempFile();
    final alldata = await getTaskJson(TodayFile);
    final clearData = Map<String, dynamic>.from(alldata);
    final notClearData = Map<String, dynamic>.from(alldata);
    notClearData.removeWhere((key, value) => value == true);
    clearData.removeWhere((key, value) => value == false);

    if (notClearData.isEmpty && clearData.isNotEmpty) {
      userNotifier.AllClearToday();
    }
    clearData.forEach((key, value) {
      print(taskNotifier);
      taskNotifier.ComplateTask(id: key);
    });
  }

  Future<Map<String, dynamic>> getTaskJson(File TodayFile) async {
    try {
      final json_string = await TodayFile.readAsString();
      final data = jsonDecode(json_string);
      return data as Map<String, dynamic>;
    } catch (e, s) {
      final newFile = await DataUtils.getTodayTempFile();
      final json_string = await newFile.readAsString();
      final data = jsonDecode(json_string);
      return data as Map<String, dynamic>;
    }
  }
}
