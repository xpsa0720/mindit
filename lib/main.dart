import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/user/router/router.dart';
import 'package:mindit/user/view/screen_on_screen.dart';
// import 'package:intl/date_symbol_data_file.dart';

import 'common/view/splash_screen.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/date_symbol_data_http_request.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
// import 'common/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  runApp(ProviderScope(child: _App()));
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: ThemeData(fontFamily: "NotoSans"),
    );
  }
}

@pragma("vm:entry-point")
void ScreenOnFlutterMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MaterialApp(home: ScreenOnScreen())));
}
