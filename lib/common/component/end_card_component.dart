import 'package:flutter/material.dart';

import 'Box_component.dart';

class EndCardComponent extends StatelessWidget {
  final TabController superTabController;
  const EndCardComponent({super.key, required this.superTabController});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        superTabController.animateTo(2);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: BoxComponent(height: 50, child: Icon(Icons.add)),
      ),
    );
  }
}
