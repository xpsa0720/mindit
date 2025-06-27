import 'dart:io';

import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_model.dart';

class TodayDataModel extends ModelBase {
  final File todayFile;
  final List<TaskModel> todayTaskList;
  TodayDataModel({required this.todayFile, required this.todayTaskList});
}
