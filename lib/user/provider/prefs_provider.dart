import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/model/prefs_model.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final prefsStateNotifierProvider =
    StateNotifierProvider<prefsStateNotifier, ModelBase>((ref) {
      return prefsStateNotifier();
    });

class prefsStateNotifier extends StateNotifier<ModelBase> {
  prefsStateNotifier() : super(ModelLoading());

  InitPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    state = PrefsModel(prefs: prefs);
  }
}
