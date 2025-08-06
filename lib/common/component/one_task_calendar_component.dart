import 'package:flutter/material.dart';
import 'package:mindit/common/data/color.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../task/model/task_model.dart';

class OneTaskCalendarComponent extends StatefulWidget {
  final TaskModel taskModel;
  const OneTaskCalendarComponent({super.key, required this.taskModel});

  @override
  State<OneTaskCalendarComponent> createState() => _CalendarComponentState();
}

class _CalendarComponentState extends State<OneTaskCalendarComponent> {
  DateTime focuseDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    List<DateTime> taskModel_day_list = widget.taskModel.clearDay;
    print("taskModel_day_list: ${taskModel_day_list}");
    return TableCalendar(
      availableGestures: AvailableGestures.none,
      key: PageStorageKey('calendar'),
      firstDay: DateTime(2000, 10, 16),
      lastDay: DateTime(2060, 3, 14),
      focusedDay: focuseDay,
      holidayPredicate:
          (day) => DataUtils.containsSameDay(taskModel_day_list, day),

      //--------------------------------
      calendarBuilders: CalendarBuilders(
        holidayBuilder: (context, day, focusedDay) {
          return Center(
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: CLEAR_COLOR,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '${day.day}',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          );
        },
      ),
      onPageChanged: (focusedDay) {
        this.focuseDay = focusedDay;
      },
      headerVisible: true,
      headerStyle: HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.black, fontSize: 17),
        weekendStyle: TextStyle(color: Colors.black, fontSize: 17),
      ),
      daysOfWeekHeight: 40,
      locale: 'ko_KR',
      calendarStyle: CalendarStyle(
        defaultTextStyle: TextStyle(color: Colors.black, fontSize: 17),
        weekendTextStyle: TextStyle(color: Colors.black38, fontSize: 17),
        outsideTextStyle: TextStyle(color: Colors.black38, fontSize: 17),
        todayTextStyle: TextStyle(color: Colors.black, fontSize: 17),
        selectedTextStyle: TextStyle(color: Colors.white, fontSize: 17),
        selectedDecoration: BoxDecoration(
          color: Color(0xFFa4c9fe),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
      selectedDayPredicate: (DateTime day) {
        return day == selectedDay;
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          if (this.selectedDay == selectedDay) {
            this.selectedDay = null;
          } else
            this.selectedDay = selectedDay;
          this.focuseDay = focusedDay;
        });
      },
    );
  }
}
