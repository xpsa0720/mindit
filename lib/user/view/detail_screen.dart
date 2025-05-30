import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/common/data/color.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/task/model/param_model.dart';
import 'package:mindit/task/model/task_state_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';

import '../../common/component/detail_task_card.dart';
import '../../task/model/task_model.dart';
import '../provider/reroad_provider.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final ScrollController controller;

  final TabController superTabController;
  const DetailScreen({
    super.key,
    required this.superTabController,
    required this.controller,
  });

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen>
    with SingleTickerProviderStateMixin {
  List<TaskModel> DBdata = [];
  bool isLoading = false;
  int start_id = 0;
  int end_id = 20;
  int id_increase = 20;
  bool isEnd = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoadingData();
    widget.controller.addListener(ControllerListener);
  }

  ControllerListener() async {
    if (!isLoading &&
        widget.controller.offset >
            widget.controller.position.maxScrollExtent - 10) {
      await LoadingData();
    }
  }

  LoadingData() async {
    isLoading = true;
    final addData = await ref.read(
      TaskModelCursorProvider(
        TaskModel_Praram(start_id: this.start_id, end_id: this.end_id),
      ),
    );

    if (addData.isNotEmpty) {
      DBdata.addAll(addData);
      start_id += id_increase;
      end_id += id_increase;
    }

    setState(() {});
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.controller,
      itemCount: DBdata.length + 1,
      itemBuilder: (context, index) {
        if (index == DBdata.length) {
          if (isLoading)
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );

          return GestureDetector(
            onTap: () {
              widget.superTabController.animateTo(2);
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: BoxComponent(height: 50, child: Icon(Icons.add)),
            ),
          );
        }
        return DetailTaskCard(DBdata: DBdata[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }
}

// final reloading = ref.read(reloadProvider);
// if (reloading) {
// DBdata = [];
// start_id = 0;
// end_id = 20;
// ref.read(reloadProvider.notifier).reloading(false);
// setState(() {});
// }
