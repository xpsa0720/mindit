import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../user/model/user_information.dart';
import '../../user/provider/user_information_provider.dart';
import 'Box_component.dart';

class DashBoardBoxComponent extends ConsumerStatefulWidget {
  const DashBoardBoxComponent({super.key});

  @override
  ConsumerState<DashBoardBoxComponent> createState() =>
      _DashBoardBoxComponentState();
}

class _DashBoardBoxComponentState extends ConsumerState<DashBoardBoxComponent> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(UserInformationStateNotifierProvider);
    if (state is! UserInformation) {
      return Center(child: CircularProgressIndicator(color: Colors.black));
    }
    return BoxComponent(
      height: 300,
      child: Text(
        '연속 ${state.sequenceDay}일 퍼펙트!!',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
      ),
    );
  }
}
