import 'package:flutter/material.dart';
import 'package:mindit/common/component/logo_component.dart';

import '../data/color.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final TabBar tabBar;
  final String? titile;

  const DefaultLayout({
    super.key,
    required this.child,
    required this.tabBar,
    this.titile,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: true,
      appBar: renderAppBar(),
      body: Column(children: [Expanded(child: child)]),
      backgroundColor: BACKGROUND_COLOR,
    );
  }

  renderAppBar() {
    if (titile == null)
      return;
    else {
      return AppBar(
        title: LogoComponent(size: 30),
        actions: [SizedBox(width: 18)],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),

          child: Column(children: [tabBar]),
        ),
        backgroundColor: Colors.white,

        // elevation: 4,
      );
    }
  }

  Shadow() {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        color: BACKGROUND_COLOR,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 1),
            blurRadius: 6,
            offset: Offset(0, 2), // x, y 방향으로 그림자 이동
          ),
        ],
      ),
    );
  }
}
