import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mindit/common/component/box_component.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../common/component/calendar_component.dart';
import '../../common/component/list_component.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        BoxComponent(
          // child: Text('1'),
          child: CalendarComponent(),
        ),
        Row(
          children: [
            Expanded(
              child: BoxComponent(
                height: 300,
                child: Text(
                  '연속 N일차!!',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: BoxComponent(
                height: 300,
                child: ListView.separated(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return ListComponent();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                ),
              ),
              flex: 6,
            ),
          ],
        ),
      ],
    );
  }
}
