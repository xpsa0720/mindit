import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/layout/default_layout.dart';
import 'package:mindit/common/provider/tabcontroller_provider.dart';
import 'package:mindit/sqlite/model/base_model.dart';

import '../../user/router/router.dart';
import '../../user/view/dash_board_screen.dart';
import '../../user/view/data_plus_screen.dart';
import '../../user/view/detail_screen.dart';
import '../../user/view/setting_screen.dart';
import '../model/tabcontroller_model.dart';

class RootTab extends ConsumerStatefulWidget {
  final Widget child;

  const RootTab({super.key, required this.child});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;
  List<String> tabBarList = ['대시보드', '상세', '추가', '설정'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(TabControllerProvider) is! CustomTabController) {
        ref
            .read(TabControllerProvider.notifier)
            .InitTabController(length: 4, vsync: this);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(TabControllerProvider);
    if (state is ModelLoading)
      return Center(child: CircularProgressIndicator());
    final TabController controller = (state as CustomTabController).controller;
    return DefaultLayout(
      titile: 'MindIt',
      tabBar: TabBar(
        controller: controller,
        onTap: (index) {
          context.go(locationPath[index]);
          ref.read(TabControllerProvider.notifier).AnimationTo(index: index);
        },
        tabs:
            tabBarList
                .map(
                  (e) => Tab(
                    child: Text(
                      e,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 17.2,
                      ),
                    ),
                  ),
                )
                .toList(),
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStateColor.resolveWith((state) {
          return Colors.transparent;
        }),
        dividerColor: Colors.transparent,
        labelColor: Colors.black,
        indicatorColor: Colors.black,
        indicatorWeight: 1,
        isScrollable: false,
        indicatorAnimation: TabIndicatorAnimation.linear,
      ),
      // child: widget.child,
      child: TabBarView(
        controller: controller,
        children: [
          DashBoardScreen(),
          DetailScreen(key: PageStorageKey('DetailScreen')),
          DataPlusScreen(),
          SettingScreen(),
        ],
      ),
    );
  }
}
