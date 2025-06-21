import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/view/root_tab.dart';
import 'package:mindit/common/view/splash_screen.dart';
import 'package:mindit/user/view/dash_board_screen.dart';
import 'package:mindit/user/view/data_plus_screen.dart';
import 'package:mindit/user/view/setting_screen.dart';

import '../view/detail_screen.dart';

final List<String> locationPath = [
  DashBoardScreen.routePath,
  DetailScreen.routePath,
  DataPlusScreen.routePath,
  SettingScreen.routePath,
];

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => SplashScreen()),
    ShellRoute(
      builder: (context, state, child) => RootTab(child: child),
      routes: [
        GoRoute(
          path: DashBoardScreen.routePath,
          builder: (_, state) => DashBoardScreen(),
        ),
        GoRoute(
          path: DetailScreen.routePath,
          builder: (_, state) => DetailScreen(),
        ),
        GoRoute(
          path: DataPlusScreen.routePath,
          builder: (_, state) => DataPlusScreen(),
        ),
        GoRoute(
          path: SettingScreen.routePath,
          builder: (_, state) => SettingScreen(),
        ),
      ],
    ),
  ],
);
