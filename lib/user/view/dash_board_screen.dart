import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/box_component.dart';
import 'package:mindit/common/component/end_card_component.dart';
import 'package:mindit/common/component/render_loading_component.dart';
import 'package:mindit/common/component/text_component.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/task/model/task_checkbox_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../common/component/button_component.dart';
import '../../common/component/calendar_component.dart';
import '../../common/component/check_dialog_component.dart';
import '../../common/component/dialog_component.dart';
import '../../common/component/list_component.dart';
import '../../common/component/text_filed_component.dart';
import '../../common/model/pagination_model.dart';
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
  // final List<AnimationController> checkController_list = [];
  // final List<Animation<double>> animation_list = [];
  bool requestName = false;
  late ScrollController scrollController;
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
    if (user is ModelError) {
      print(user.message);
      if (user.jsonNull == true) {
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
    final List<TaskCheckBoxModel> taskCheckBoxModelList = [];

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

    List.generate(cp.TaskModels.length - taskCheckBoxModelList.length, (index) {
      // final standardIndex = checkController_list.length;
      final checkController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      );
      taskCheckBoxModelList.add(
        TaskCheckBoxModel(
          model: cp.TaskModels[index],
          checkController: checkController,
          animation: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              parent: checkController,
              curve: Curves.easeInOutCirc,
            ),
          ),
        ),
      );
    });

    return ListView(
      children: [
        BoxComponent(child: SizedBox(child: CalendarComponent())),
        Container(
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: Text("광고"),
        ),
        Row(
          children: [
            Expanded(
              flex: 5,

              child: BoxComponent(
                height: 300,
                child: Text(
                  '연속 5일 퍼펙트!!',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            Expanded(
              flex: 7,

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
                                ? Text('')
                                : RenderLoadingComponent();
                          return ListComponent(
                            model: taskCheckBoxModelList[index].model,
                            animation: taskCheckBoxModelList[index].animation,
                            checkController:
                                taskCheckBoxModelList[index].checkController,
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
            ),
          ],
        ),
      ],
    );
  }

  // ComplateCard() {
  //   return GestureDetector(
  //     onTap: () {
  //       CheckDialogComponent(
  //          context: context,
  //         No_function: ,
  //         () {
  //           Navigator.pop(context);
  //         },
  //         () {
  //           Navigator.pop(context);
  //           // Complate();
  //         },
  //       );
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.only(bottom: 10.0),
  //       child: BoxComponent(
  //         shadow: false,
  //         height: 50,
  //         child: Center(child: TextComponent(text: '완료')),
  //       ),
  //     ),
  //   );
  // }
}
