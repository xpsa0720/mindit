import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/task/model/task_state_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../common/component/button_component.dart';
import '../../common/component/detail_task_card.dart';
import '../../common/component/list_pagination_component.dart';
import '../../task/model/task_model.dart';
import '../../task/util/dummy_data.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final TabController superTabController;
  const DetailScreen({super.key, required this.superTabController});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ListPaginationComponent(
      superTabController: widget.superTabController,
    );
  }
}
