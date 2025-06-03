import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/common/component/render_loading_component.dart';
import 'package:mindit/task/model/task_state_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../common/component/button_component.dart';
import '../../common/component/detail_task_card.dart';
import '../../task/util/dummy_data.dart';
import 'end_card_component.dart';

class ListPaginationComponent extends ConsumerStatefulWidget {
  final TabController superTabController;

  const ListPaginationComponent({super.key, required this.superTabController});

  @override
  ConsumerState<ListPaginationComponent> createState() =>
      _ListPaginationComponentState();
}

class _ListPaginationComponentState
    extends ConsumerState<ListPaginationComponent>
    with SingleTickerProviderStateMixin {
  late ScrollController controller;
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
    final state = ref.watch(TaskModelPaginationStateNotifierProvider);

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

    final cp = ref.watch(TaskModelStateNotifierProvider);
    return ListView.separated(
      controller: controller,
      itemCount:
          state is PaginationMore && cp.TaskModels.isEmpty
              ? 10
              : cp.TaskModels.length + 1,
      itemBuilder: (context, index) {
        if (state is PaginationMore && cp.TaskModels.isEmpty) {
          return Skeletonizer(
            enabled: true,
            child: DetailTaskCard(DBdata: dummyModel),
          );
        }
        if (index == cp.TaskModels.length)
          return cp.isEnd
              ? EndCardComponent(superTabController: widget.superTabController)
              : RenderLoadingComponent();
        return DetailTaskCard(DBdata: cp.TaskModels[index]);
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }
}
