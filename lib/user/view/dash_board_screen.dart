import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/box_component.dart';
import 'package:mindit/common/component/end_card_component.dart';
import 'package:mindit/common/component/render_loading_component.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../common/component/button_component.dart';
import '../../common/component/calendar_component.dart';
import '../../common/component/list_component.dart';
import '../../common/model/pagination_model.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  final TabController superTabController;
  const DashBoardScreen({super.key, required this.superTabController});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  final List<AnimationController> checkController_list = [];
  final List<Animation<double>> animation_list = [];

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

    List.generate(cp.TaskModels.length - checkController_list.length, (index) {
      // final standardIndex = checkController_list.length;
      checkController_list.add(
        AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 300),
        ),
      );
      animation_list.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: checkController_list.last,
            curve: Curves.easeInOutCirc,
          ),
        ),
      );
    });

    return ListView(
      children: [
        BoxComponent(child: CalendarComponent()),
        Row(
          children: [
            Expanded(
              child: BoxComponent(
                height: 300,
                child: Text(
                  '연속 5일 퍼펙트!!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
              flex: 5,
            ),

            Expanded(
              child: BoxComponent(
                height: 300,
                child: Column(
                  children: [
                    Text(
                      '오늘 할일은...',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount:
                            state is PaginationMore && cp.TaskModels.isEmpty
                                ? 5
                                : cp.TaskModels.length + 1,
                        itemBuilder: (context, index) {
                          if (state is PaginationMore &&
                              cp.TaskModels.isEmpty) {
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
                          return ListComponent(
                            model: cp.TaskModels[index],
                            animation: animation_list[index],
                            checkController: checkController_list[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 8);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              flex: 7,
            ),
          ],
        ),
      ],
    );
  }
}
