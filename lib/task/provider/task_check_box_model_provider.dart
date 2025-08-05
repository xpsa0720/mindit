import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/task/model/task_checkbox_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';

import '../model/task_model.dart';

final taskCheckBoxModelProvider = StateNotifierProvider.family<
  TaskCheckBoxModelStateNotifier,
  List<TaskCheckBoxModel>,
  TickerProvider
>((ref, vsync) {
  final model = ref.watch(TaskModelStateNotifierProvider);
  return TaskCheckBoxModelStateNotifier(
    models: model.toDayTasks(),
    vsync: vsync,
  );
});

class TaskCheckBoxModelStateNotifier
    extends StateNotifier<List<TaskCheckBoxModel>> {
  final List<TaskModel> models;
  final TickerProvider vsync;
  TaskCheckBoxModelStateNotifier({required this.models, required this.vsync})
    : super([]) {
    update(vsync: vsync);
  }

  update({required TickerProvider vsync}) {
    final List<TaskCheckBoxModel> result = [];
    List.generate(models.length, (index) {
      final checkController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 300),
      );
      result.add(
        TaskCheckBoxModel(
          model: models[index],
          checkController: checkController,
          animation: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: checkController,
              curve: Curves.easeInOutCirc,
            ),
          ),
        ),
      );
    });
    state = result;
  }

  addModel(TaskModel model) {
    print('addModel 실행');

    final checkController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 300),
    );
    state = [
      ...state,
      TaskCheckBoxModel(
        model: model,
        checkController: checkController,
        animation: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: checkController, curve: Curves.easeInOutCirc),
        ),
      ),
    ];
  }

  deleteModel(TaskModel model) {
    state.removeWhere((e) => e.model.id == model.id);
    state = state;
  }

  setModel(List<TaskCheckBoxModel> models) {
    state = models;
  }
}
