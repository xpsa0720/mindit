import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/sqlite/model/base_model.dart';

final toDayFileStateNotifierProvider =
    StateNotifierProvider<ToDayFileStateNotifier, ModelBase>((ref) {
      return ToDayFileStateNotifier();
    });

class ToDayFileStateNotifier extends StateNotifier<ModelBase> {
  ToDayFileStateNotifier() : super(ModelLoading());
}
