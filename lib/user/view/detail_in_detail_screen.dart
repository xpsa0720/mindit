import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/provider/tabcontroller_provider.dart';
import 'package:mindit/user/view/detail_screen.dart';

import '../../common/data/color.dart';
import '../../task/model/task_model.dart';

class DetailInDetailScreen extends ConsumerStatefulWidget {
  static String get routeFullPath =>
      '/${DetailScreen.routePath}/detailIndetail';
  static String get routePath => 'detailIndetail';

  final TaskModel data;
  const DetailInDetailScreen({super.key, required this.data});

  @override
  ConsumerState<DetailInDetailScreen> createState() =>
      _DetailInDetailScreenState();
}

class _DetailInDetailScreenState extends ConsumerState<DetailInDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: BACKGROUND_COLOR,
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          context.go(DetailScreen.routeFullPath);
          ref.read(TabControllerProvider.notifier).AnimationTo(index: 1);
        },
        child: SafeArea(child: Container(color: BACKGROUND_COLOR)),
      ),
    );
  }
}
