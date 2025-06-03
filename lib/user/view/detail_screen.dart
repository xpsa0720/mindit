import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/task/model/task_state_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../common/component/button_component.dart';
import '../../common/component/detail_task_card.dart';
import '../../common/component/list_pagination_component.dart';
import '../../task/model/task_model.dart';
import '../../task/util/dummy_data.dart';

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
    controller = ScrollController();
    controller.addListener(ControllerListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    controller.removeListener(ControllerListener);
  }

  ControllerListener() async {
    if (controller.offset > controller.position.maxScrollExtent - 300) {
      await ref
          .read(TaskModelPaginationStateNotifierProvider.notifier)
          .paginate();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListPaginationComponent(
      superTabController: widget.superTabController,
    );
  }

  renderLoading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(color: Colors.black),
      ),
    );
  }

  EndCard() {
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
}
