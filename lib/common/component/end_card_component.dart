import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/provider/tabcontroller_provider.dart';
import 'package:mindit/user/view/data_plus_screen.dart';

import 'Box_component.dart';

class EndCardComponent extends ConsumerStatefulWidget {
  const EndCardComponent({super.key});

  @override
  ConsumerState<EndCardComponent> createState() => _EndCardComponentState();
}

class _EndCardComponentState extends ConsumerState<EndCardComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(TabControllerProvider.notifier).AnimationTo(index: 2);
        context.go(DataPlusScreen.routeFullPath);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: BoxComponent(height: 50, child: Icon(Icons.add)),
      ),
    );
  }
}
