import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/logo_component.dart';
import 'package:mindit/common/view/root_tab.dart';
import 'dart:async';

import '../../sqlite/provider/db_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool InitDBLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    InitDB();
  }

  InitDB() async {
    await ref.read(dbProvider.notifier).InitDB();
    setState(() {
      InitDBLoading = true;
    });
  }

  checkData() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => RootTab()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (InitDBLoading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) => checkData());
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            LogoComponent(size: 50),
            SizedBox(height: 20),
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: Colors.black,
                strokeCap: StrokeCap.round,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
