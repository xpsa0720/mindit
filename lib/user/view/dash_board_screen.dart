import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:mindit/common/component/box_component.dart';
import 'package:mindit/common/component/end_card_component.dart';
import 'package:mindit/common/component/render_loading_component.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:mindit/task/util/dummy_data.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/component/button_component.dart';
import '../../common/component/calendar_component.dart';
import '../../common/component/list_component.dart';
import '../../task/model/task_state_model.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  final TabController superTabController;
  const DashBoardScreen({super.key, required this.superTabController});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  late ScrollController scrollController;

  ControllerListener() async {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 60) {
      await ref
          .read(TaskModelPaginationStateNotifierProvider.notifier)
          .paginate();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(ControllerListener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
    scrollController.removeListener(ControllerListener);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final state = ref.watch(TaskModelPaginationStateNotifierProvider);
    final cp = ref.watch(TaskModelStateNotifierProvider);

    if (state is PaginationError) {
      final cp = state as PaginationError;
      print(cp.message);
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('에러가 났습니다!'),
            ButtonComponent(
              text: '로딩',
              callback: () {
                ref
                    .read(TaskModelPaginationStateNotifierProvider.notifier)
                    .paginate();
              },
              enableColor: false,
            ),
          ],
        ),
      );
    }
    return ListView(
      children: [
        BoxComponent(child: CalendarComponent()),
        Row(
          children: [
            Expanded(
              child: BoxComponent(
                height: 300,
                child: Text(
                  '연속 N일차!!',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                ),
              ),
              flex: 5,
            ),

            Expanded(
              child: BoxComponent(
                height: 300,
                child: ListView.separated(
                  controller: scrollController,
                  itemCount:
                      state is PaginationMore && cp.TaskModels.isEmpty
                          ? 5
                          : cp.TaskModels.length + 1,
                  itemBuilder: (context, index) {
                    if (state is PaginationMore && cp.TaskModels.isEmpty) {
                      return Skeletonizer(
                        enabled: state is PaginationMore,
                        child: ListComponent(),
                      );
                    }
                    if (index == cp.TaskModels.length)
                      return cp.isEnd
                          ? EndCardComponent(
                            superTabController: widget.superTabController,
                          )
                          : RenderLoadingComponent();
                    return ListComponent(model: cp.TaskModels[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                ),
              ),
              flex: 6,
            ),
          ],
        ),
      ],
    );
  }
}
