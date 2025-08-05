import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/sqlite/model/base_model.dart';
import 'package:mindit/user/model/user_information.dart';
import 'package:mindit/user/provider/user_information_provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../data/color.dart';
import '../util/data_util.dart';

class CalendarComponent extends ConsumerStatefulWidget {
  const CalendarComponent({super.key});

  @override
  ConsumerState<CalendarComponent> createState() => _CalendarComponentState();
}

class _CalendarComponentState extends ConsumerState<CalendarComponent> {
  DateTime focuseDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(UserInformationStateNotifierProvider);
    if (state is ModelLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (state is ModelError) {
      print((state as ModelError).message);
      return Center(child: CircularProgressIndicator());
    }
    final cp = state as UserInformation;
    return TableCalendar(
      availableGestures: AvailableGestures.none,
      key: PageStorageKey('calendar'),
      firstDay: DateTime.utc(2000, 10, 16),
      lastDay: DateTime.utc(2060, 3, 14),
      focusedDay: focuseDay,

      //--------------------------------
      holidayPredicate:
          (day) => DataUtils.containsSameDay(cp.allClearDays, day),

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
                  style: TextStyle(color: Colors.black87, fontSize: 17),
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
        todayTextStyle: TextStyle(color: Colors.white, fontSize: 17),
        selectedTextStyle: TextStyle(color: Colors.white, fontSize: 17),
        selectedDecoration: BoxDecoration(
          color: Color(0xFFa4c9fe),
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Colors.black38,
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
