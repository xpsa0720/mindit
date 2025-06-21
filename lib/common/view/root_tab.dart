import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/layout/default_layout.dart';

import '../../user/router/router.dart';
import '../../user/view/dash_board_screen.dart';
import '../../user/view/data_plus_screen.dart';
import '../../user/view/detail_screen.dart';
import '../../user/view/setting_screen.dart';

class RootTab extends StatefulWidget {
  final Widget child;
  const RootTab({super.key, required this.child});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController tabBarController;

  List<String> tabBarList = ['대시보드', '상세', '추가', '설정'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabBarController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tabBarController.dispose();
    print('dispose');
  }

  int getIndex(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.toString();
    if (currentPath == DashBoardScreen.routePath) return 0;
    if (currentPath == DetailScreen.routePath) return 1;
    if (currentPath == DataPlusScreen.routePath) return 2;
    if (currentPath == SettingScreen.routePath) return 3;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      titile: 'MindIt',
      tabBar: TabBar(
        controller: tabBarController,
        onTap: (index) {
          context.go(locationPath[index]);
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
        labelColor: Colors.black, // 선택된 탭의 텍스트 색상
        indicatorColor: Colors.black,
        indicatorWeight: 1,
        isScrollable: false,
        indicatorAnimation: TabIndicatorAnimation.linear,
      ),
      // child: widget.child,
      child: TabBarView(
        controller: tabBarController,
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
