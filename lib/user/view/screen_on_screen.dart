import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/data/sqlite.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/sqlite/model/db_helper.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:path_provider/path_provider.dart';

import '../../sqlite/provider/db_provider.dart';
import '../foreground/util.dart';

class ScreenOnScreen extends ConsumerStatefulWidget {
  const ScreenOnScreen({super.key});

  @override
  ConsumerState<ScreenOnScreen> createState() => _ScreenOnScreenState();
}

class _ScreenOnScreenState extends ConsumerState<ScreenOnScreen> {
  bool InitDBLoading = false;
  DataInit() async {}

  InitDB({Function? InitFunction}) async {
    await ref.read(dbProvider.notifier).InitDB();
    if (InitFunction != null) {
      InitFunction();
    }
    setState(() {
      InitDBLoading = true;
    });
  }

  @override
  void initState() {
    super.initState();
    InitDB(InitFunction: DataInit);
  }

  @override
  Widget build(BuildContext context) {
    if (!InitDBLoading)
      return Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.black)),
      );

    return Scaffold(body: Center(child: Text('')));
  }
}
