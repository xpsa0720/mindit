import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/user/view/dash_board_screen.dart';
import 'package:mindit/user/view/data_plus_screen.dart';
import 'package:mindit/user/view/setting_screen.dart';

import '../../../common/view/root_tab.dart';
import '../../../common/view/splash_screen.dart';
import '../../view/detail_screen.dart';
import '../../view/error_screen.dart';
import '../../view/lock_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: SplashScreen.routeFullPath,
    routes: [
      GoRoute(
        path: SplashScreen.routeFullPath,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: LockScreen.routeFullPath,
        builder: (_, state) => LockScreen(),
      ),
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
});
