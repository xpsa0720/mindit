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
  final TabController superTabController;
  const DetailScreen({super.key, required this.superTabController});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  late ScrollController controller;
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
    controller = ScrollController();
    controller.addListener(ControllerListener);
    print('initState()');
    print('${start_id}');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    controller.removeListener(ControllerListener);
  }

  ControllerListener() async {
    if (!isLoading &&
        controller.offset > controller.position.maxScrollExtent - 300) {
      await LoadingData();
    }
  }

  LoadingData() async {
    isLoading = true;
    setState(() {});
    await Future.delayed(Duration(seconds: 2));

    final addData = await ref.read(
      TaskModelCursorProvider(
        TaskModel_Praram(
          start_id: this.start_id,
          end_id: this.end_id,
          length: this.id_increase,
        ),
      ),
    );
    if (addData.TaskModels.isNotEmpty) {
      start_id += id_increase;
      end_id += id_increase;
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final DBdata = ref.watch(TaskStateModelProvider);
    print(DBdata.TaskModels.length);
    return ListView.separated(
      controller: controller,
      itemCount: DBdata.TaskModels.length,
      itemBuilder: (context, index) {
        if (index == DBdata.TaskModels.length - 1) {
          if (isLoading)
            return Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          if (DBdata.TaskModels[index].id == -1)
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
        return DetailTaskCard(DBdata: DBdata.TaskModels[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }
}
