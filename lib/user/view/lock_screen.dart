import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/task/provider/task_check_box_model_provider.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:mindit/user/provider/time_provider.dart';
import 'package:screen_on_flutter/screen_on_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../common/component/list_component.dart';
import '../../common/component/pen_list_component.dart';
import '../foreground/util.dart';
import '../provider/foreground_provider.dart';
import '../provider/screen_on_service_provider.dart';
import 'data_plus_screen.dart';
import 'package:intl/intl.dart';

class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({super.key});

  static String get routeFullPath => '/';

  static String get routePath => '';

  @override
  ConsumerState<LockScreen> createState() => _ScreenOnScreenState();
}

class _ScreenOnScreenState extends ConsumerState<LockScreen> {
  double _dragPosition = 0.0;
  double _maxDrag = 400;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _dragPosition += details.delta.dx;
            _dragPosition = _dragPosition.clamp(0.0, _maxDrag);
          });
        },
        onHorizontalDragEnd: (_) {
          if (_dragPosition > 50) {
            ref.read(screenServiceProvider).moveToBack();

            setState(() {
              _dragPosition = 0.0;
            });
          } else {
            setState(() {
              _dragPosition = 0.0;
            });
          }
        },
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(_dragPosition, 0),
              child: MainScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen>
    with TickerProviderStateMixin {
  int index = 0;
  late Timer _timer;
  late String _currentTime;
  late String dateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    TimerInit();
  }

  TimerInit() {
    _currentTime = _getFormattedTime();
    final now = DateTime.now();
    dateTime = DateFormat('MM월 dd일 (EEEE)', 'ko_KR').format(now);
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getFormattedTime();
      });
    });
  }

  String _getFormattedTime() {
    final now = DateTime.now();
    return DateFormat('HH:mm').format(now);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  ComplateToday() async {
    await ref.watch(ForegroundServiceProvider.notifier).complateToday();
    ref.read(TimeStateNotifierProvider.notifier).UpdateTime();
  }

  @override
  Widget build(BuildContext context) {
    final state =
        ref.watch(TaskModelStateNotifierProvider.notifier).toDayTasks();
    final time = ref.read(TimeStateNotifierProvider);
    final checkBoxState = ref.watch(taskCheckBoxModelProvider(this));
    final stateTask = ref.watch(ForegroundServiceProvider);
    final currentTime = DateTime.now();
    if (isSameDay(time, currentTime.subtract(Duration(days: 1)))) {
      ComplateToday();
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("asset/image/background.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 80),
          Text(
            _currentTime,
            style: TextStyle(
              fontSize: 70,
              fontFamily: "Dovemayo",
              color: Colors.black87,
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(
            dateTime,
            style: TextStyle(
              fontSize: 35,
              fontFamily: "PenCel",
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 30),

          SizedBox(
            height: 400,
            child: ListView.separated(
              itemCount: state.length,
              itemBuilder: (context, index) {
                if (stateTask is! ForegroundService)
                  return Skeletonizer(
                    enabled: true,
                    child: ListComponent(boxFill: false),
                  );
                final stateTask_cp = stateTask as ForegroundService;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PenListComponent(
                      size: 40,
                      boxFill: false,
                      check:
                          stateTask_cp.stateTask[checkBoxState[index].model.id
                              .toString()],
                      model: checkBoxState[index].model,
                      animation: checkBoxState[index].animation,
                      checkController: checkBoxState[index].checkController,
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              context.go(DataPlusScreen.routeFullPath);
            },
            child: Text(
              '일정 더하기',
              style: TextStyle(
                fontFamily: "PenCel",
                fontWeight: FontWeight.w100,
                color: Colors.black87,
                fontSize: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
