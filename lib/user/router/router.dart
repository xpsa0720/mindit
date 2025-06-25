import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/view/root_tab.dart';
import 'package:mindit/common/view/splash_screen.dart';
import 'package:mindit/user/view/dash_board_screen.dart';
import 'package:mindit/user/view/data_plus_screen.dart';
import 'package:mindit/user/view/detail_in_detail_screen.dart';
import 'package:mindit/user/view/setting_screen.dart';

import '../../task/model/task_model.dart';
import '../view/detail_screen.dart';
import '../view/error_screen.dart';

final List<String> locationPath = [
  DashBoardScreen.routeFullPath,
  DetailScreen.routeFullPath,
  DataPlusScreen.routeFullPath,
  SettingScreen.routeFullPath,
];

final router = GoRouter(
  initialLocation: SplashScreen.routeFullPath,
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => SplashScreen()),
    ShellRoute(
      builder: (context, state, child) => RootTab(child: child),
      routes: [
        GoRoute(
          path: DashBoardScreen.routeFullPath,
          builder: (_, state) => DashBoardScreen(),
        ),
        GoRoute(
          path: DetailScreen.routeFullPath,
          builder: (_, state) => DetailScreen(),
        ),
        GoRoute(
          path: DataPlusScreen.routeFullPath,
          builder: (_, state) => DataPlusScreen(),
        ),
        GoRoute(
          path: SettingScreen.routeFullPath,
          builder: (_, state) => SettingScreen(),
        ),
      ],
    ),
    GoRoute(
      path: ErrorScreen.routeFullPath,
      builder: (_, state) => ErrorScreen(),
    ),
  ],
);
