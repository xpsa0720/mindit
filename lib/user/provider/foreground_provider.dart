import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/sqlite/model/db_helper.dart';
import 'package:mindit/sqlite/provider/db_provider.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:mindit/user/foreground/util.dart';
import 'package:mindit/user/model/todayfile_model.dart';
import 'package:mindit/user/provider/todayfile_provider.dart';
import 'package:path_provider/path_provider.dart';

import '../../task/model/task_model.dart';

final ForegroundServiceProvider =
    StateNotifierProvider<ForegroundStateNotifier, ModelBase>((ref) {
      final toDayFile =
          ref.watch(toDayFileStateNotifierProvider) as TodayDataModel;
      return ForegroundStateNotifier(
        models: toDayFile.todayTaskList,
        TodayFile: toDayFile.todayFile,
      );
    });

class ForegroundStateNotifier extends StateNotifier<ModelBase> {
  final File TodayFile;
  final List<TaskModel> models;
  ForegroundStateNotifier({required this.TodayFile, required this.models})
    : super(ModelLoading()) {
    Update();
  }

  void Update() async {
    await UpdateTask();
    state = ForegroundService();
  }

  Future<void> UpdateTask() async {
    final json = await getTaskJson();
    final List<int> list = [for (final i in json.keys) int.parse(i)];
    final different_Idlist = models.where((e) => list.contains(e)).toList();
    final insert_data = {for (final i in different_Idlist) models[i.id]: false};
    print(insert_data);
    await TodayFile.writeAsString(jsonEncode(insert_data));
  }

  complateTask(TaskModel model) async {
    final taskJson = await getTaskJson();
    taskJson[model.id] = true;
    await TodayFile.writeAsString(jsonEncode(taskJson)); // 저장
  }

  cancelTask(TaskModel model) async {
    final taskJson = await getTaskJson();
    taskJson[model.id] = false;
    await TodayFile.writeAsString(jsonEncode(taskJson)); // 저장
  }

  getTaskJson() async {
    final json_string = await TodayFile.readAsString();
    final data = jsonDecode(json_string);
    return data;
  }
}
