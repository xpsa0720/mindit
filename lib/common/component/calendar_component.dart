import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarComponent extends StatefulWidget {
  const CalendarComponent({super.key});

  @override
  State<CalendarComponent> createState() => _CalendarComponentState();
}

class _CalendarComponentState extends State<CalendarComponent> {
  DateTime focuseDay = DateTime.now();
  DateTime? selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2000, 10, 16),
      lastDay: DateTime.utc(2060, 3, 14),
      focusedDay: focuseDay,

      //--------------------------------
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
