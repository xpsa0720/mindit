import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/user/view/data_plus_screen.dart';

import 'Box_component.dart';

class EndCardComponent extends StatelessWidget {
  const EndCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(DataPlusScreen.routePath);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: BoxComponent(height: 50, child: Icon(Icons.add)),
      ),
    );
  }
}
