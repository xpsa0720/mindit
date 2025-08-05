import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/box_component.dart';
import 'package:mindit/common/component/dash_board_box_component.dart';
import 'package:mindit/common/component/end_card_component.dart';
import 'package:mindit/common/component/render_loading_component.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:mindit/user/foreground/util.dart';
import 'package:mindit/user/model/user_information.dart';
import 'package:mindit/user/provider/foreground_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../common/component/button_component.dart';
import '../../common/component/calendar_component.dart';
import '../../common/component/dialog_component.dart';
import '../../common/component/list_component.dart';
import '../../common/model/pagination_model.dart';
import '../../task/provider/task_check_box_model_provider.dart';
import '../provider/user_information_provider.dart';

class DashBoardScreen extends ConsumerStatefulWidget {
  static String get routeFullPath => '/dashboard';
  static String get routePath => 'dashboard';

  const DashBoardScreen({super.key});

  @override
  ConsumerState<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  bool requestName = false;
  late ScrollController scrollController;
  bool DataLoading = false;

  ControllerListener() async {
    if (scrollController.offset >
        scrollController.position.maxScrollExtent - 60) {
      await ref
          .read(TaskModelPaginationStateNotifierProvider.notifier)
          .paginate();
    }
  }

  UserInfoCheck() async {
    final user = ref.read(UserInformationStateNotifierProvider);
    if (user is UserInformation) {
      if (user.name == "") {
        requestName = true;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserInfoCheck();
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
    final cp_notifier = ref.watch(TaskModelStateNotifierProvider.notifier);
    final stateTask = ref.watch(ForegroundServiceProvider);
    if (requestName) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final TextEditingController textEditingController =
            TextEditingController();
        GetNameDialogComponent(
          context: context,
          textController: textEditingController,
          No_function: () {
            ref
                .read(UserInformationStateNotifierProvider.notifier)
                .CreateNewUserInfo();
            Navigator.pop(context);
          },
          OK_function: () {
            ref
                .read(UserInformationStateNotifierProvider.notifier)
                .CreateNewUserInfo(name: textEditingController.text);
            Navigator.pop(context);
          },
        );
        requestName = false;
      });
    }

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
    final data = cp_notifier.toDayTasks();
    final taskCheckBoxState = ref.watch(taskCheckBoxModelProvider(this));

    return ListView(
      children: [
        BoxComponent(
          boaderPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          child: SizedBox(child: CalendarComponent()),
        ),
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: Text("광고"),
        ),
        Row(
          children: [
            Expanded(flex: 5, child: DashBoardBoxComponent()),
            Expanded(
              flex: 7,
              child: BoxComponent(
                boaderPadding: EdgeInsets.only(right: 16, left: 5, top: 10),
                height: 300,
                child: Column(
                  children: [
                    Text(
                      '오늘 할일은...',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 240,
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount:
                            state is PaginationMore && data.isEmpty
                                ? 5
                                : data.length + 1,
                        itemBuilder: (context, index) {
                          if ((state is PaginationMore && data.isEmpty) ||
                              stateTask is! ForegroundService) {
                            return Skeletonizer(
                              enabled: state is PaginationMore,
                              child: ListComponent(),
                            );
                          }
                          final stateTask_cp = stateTask as ForegroundService;
                          if (data.isEmpty) return EndCardComponent();
                          // return TextComponent(text: '할일이?');

                          if (index == data.length)
                            return cp.isEnd
                                ? Text('')
                                : RenderLoadingComponent();

                          // print(taskCheckBoxModelList[1].model.title);
                          return ListComponent(
                            check:
                                stateTask_cp.stateTask[taskCheckBoxState[index]
                                    .model
                                    .id
                                    .toString()],
                            model: taskCheckBoxState[index].model,
                            animation: taskCheckBoxState[index].animation,
                            checkController:
                                taskCheckBoxState[index].checkController,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 0);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
