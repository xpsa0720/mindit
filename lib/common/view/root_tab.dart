import 'package:flutter/material.dart';
import 'package:mindit/common/layout/default_layout.dart';

import '../../user/view/dash_board_screen.dart';
import '../../user/view/data_plus_screen.dart';
import '../../user/view/detail_screen.dart';
import '../../user/view/setting_screen.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

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
  Widget build(BuildContext context) {
    return DefaultLayout(
      titile: 'MindIt',
      tabBar: TabBar(
        controller: tabBarController,
        // tabAlignment: TabAlignment.center,
        // unselectedLabelColor: Colors.grey, // 선택되지 않은 탭의 텍스트 색상
        tabs:
            tabBarList
                .map(
                  (e) => Tab(
                    child: Text(
                      e,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 19,
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
      child: TabBarView(
        controller: tabBarController,
        children: [
          DashBoardScreen(),
          DetailScreen(),
          DataPlusScreen(),
          SettingScreen(),
        ],
      ),
    );
  }
}
