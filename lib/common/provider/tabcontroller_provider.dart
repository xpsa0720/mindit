import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/sqlite/model/base_model.dart';

import '../model/tabcontroller_model.dart';

final TabControllerProvider =
    StateNotifierProvider<TabControllerStateNotifier, ModelBase>((ref) {
      return TabControllerStateNotifier();
    });

class TabControllerStateNotifier extends StateNotifier<ModelBase> {
  // final int length;
  // final TickerProvider vsync;
  TabControllerStateNotifier() : super(ModelLoading());

  InitTabController({required int length, required TickerProvider vsync}) {
    state = CustomTabController(
      controller: TabController(length: length, vsync: vsync),
    );
  }

  DisposeTabController() {
    if (state is CustomTabController)
      (state as CustomTabController).controller.dispose();
    else {
      print("컨트롤러 없음!");
    }
  }

  AnimationTo({required int index}) {
    if (state is! CustomTabController) {
      print("컨트롤러 없음!");
    }
    (state as CustomTabController).controller.animateTo(index);
    (state as CustomTabController).controller.index = index;
    state = state;
  }
}
