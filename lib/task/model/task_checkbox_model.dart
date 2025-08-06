import 'package:flutter/animation.dart';
import 'package:mindit/task/model/task_model.dart';

class TaskCheckBoxModel {
  final TaskModel model;
  final AnimationController checkController;
  final Animation<double> animation;

  TaskCheckBoxModel({
    required this.model,
    required this.checkController,
    required this.animation,
  });
}
