import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/sqlite/model/db_helper.dart';
import 'package:mindit/sqlite/provider/db_provider.dart';
import 'package:path_provider/path_provider.dart';

import '../model/todayfile_model.dart';

final toDayFileStateNotifierProvider =
    StateNotifierProvider<ToDayFileStateNotifier, ModelBase>((ref) {
      final dbHelper = ref.watch(dbHelperProvider);

      return ToDayFileStateNotifier(dbHelper: dbHelper);
    });

class ToDayFileStateNotifier extends StateNotifier<ModelBase> {
  final DbHelper dbHelper;
  ToDayFileStateNotifier({required this.dbHelper}) : super(ModelLoading());

  Future<void> Init() async {
    final path = await getTemporaryDirectory();
    final data = await DataUtils.getTodayTempFile(path);

    final todayTask = await dbHelper.GetTodayTaskList(table: TABLE_NAME);

    state = TodayDataModel(todayFile: data, todayTaskList: todayTask);
  }
}
