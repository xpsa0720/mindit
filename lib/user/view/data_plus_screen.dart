import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/task/model/day_of_week_model.dart';
import 'package:mindit/task/model/task_model.dart';

import '../../common/component/text_filed_component.dart';
import '../../common/data/sqlite.dart';
import '../../sqlite/provider/db_provider.dart';

class DataPlusScreen extends ConsumerStatefulWidget {
  const DataPlusScreen({super.key});

  @override
  ConsumerState<DataPlusScreen> createState() => _DataPlusScreenState();
}

class _DataPlusScreenState extends ConsumerState<DataPlusScreen> {
  List<String> DayOfWeek_list = ['월', '화', '수', '목', '금', '토', '일'];
  List<bool> DayOfWeek_bool_list = List.generate(7, (index) => false);
  @override
  Widget build(BuildContext context) {
    final dbHelper = ref.watch(dbHelperProvider);
    return Column(
      children: [
        BoxComponent(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(children: [renderText('실천 내용')]),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 20),
                child: TextFiledComponent(),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  renderText('활동 날짜'),
                  renderButton(
                    text: '매일',
                    callback: () {
                      setState(() {
                        everyDayEnable();
                      });
                    },
                  ),
                  renderButton(
                    text: '평일',
                    callback: () {
                      setState(() {
                        weekDayEnable();
                      });
                    },
                  ),
                  renderButton(
                    text: '주말',
                    callback: () {
                      setState(() {
                        dayofWeekEnable();
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: List.generate(7, (index) {
                  return renderDayOfWeek(
                    isEnable: DayOfWeek_bool_list[index],
                    text: DayOfWeek_list[index],
                    callback: () {
                      setState(() {
                        DayOfWeek_bool_list[index] =
                            !DayOfWeek_bool_list[index];
                      });
                    },
                  );
                }),
              ),
            ],
          ),
          width: double.infinity,
        ),
      ],
    );
  }

  Widget renderText(text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
    );
  }

  Widget renderButton({required String text, required VoidCallback callback}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ElevatedButton(
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          ),
        ),

        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.resolveWith((states) {
            return Size(60, 35);
          }),
          backgroundColor: WidgetStateColor.resolveWith((states) {
            return Colors.white;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            return 0;
          }),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(color: Colors.black),
          ),
          overlayColor: WidgetStateColor.resolveWith(
            (states) => Color(0xFFd1d1d1),
          ),
        ),
      ),
    );
  }

  everyDayEnable() {
    bool changebool = isAlleveryDayEnable();
    List.generate(7, (index) {
      DayOfWeek_bool_list[index] = changebool;
    });
    setState(() {});
  }

  isAlleveryDayEnable() {
    bool return_bool = false;
    List.generate(7, (index) {
      if (DayOfWeek_bool_list[index] == false) {
        return_bool = true;
      }
    });
    return return_bool;
  }

  weekDayEnable() {
    bool changebool = isWeekDayEnable();
    List.generate(5, (index) {
      DayOfWeek_bool_list[index] = changebool;
    });
    List.generate(2, (index) {
      DayOfWeek_bool_list[index + 5] = changebool == true ? false : false;
    });
    setState(() {});
  }

  isWeekDayEnable() {
    bool return_bool = false;
    List.generate(5, (index) {
      if (DayOfWeek_bool_list[index] == false) return_bool = true;
    });
    List.generate(2, (index) {
      if (DayOfWeek_bool_list[index + 5] == true) return_bool = true;
    });
    return return_bool;
  }

  dayofWeekEnable() {
    bool changebool = isdayofWeekEnable();
    List.generate(5, (index) {
      DayOfWeek_bool_list[index] = changebool == true ? false : false;
    });
    List.generate(2, (index) {
      DayOfWeek_bool_list[index + 5] = changebool;
    });
    setState(() {});
  }

  isdayofWeekEnable() {
    bool return_bool = false;
    List.generate(5, (index) {
      if (DayOfWeek_bool_list[index] == true) return_bool = true;
    });
    List.generate(2, (index) {
      if (DayOfWeek_bool_list[index + 5] == false) return_bool = true;
    });
    return return_bool;
  }

  renderDayOfWeek({
    required String text,
    required VoidCallback callback,
    required bool isEnable,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: isEnable == true ? Color(0xFF9afb97) : Colors.white,
            blurRadius: 10,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: Colors.black,
          ),
        ),

        style: ButtonStyle(
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.resolveWith((states) {
            return Size(40, 40);
          }),
          backgroundColor: WidgetStateColor.resolveWith((states) {
            return Colors.transparent;
          }),
          shadowColor: WidgetStateColor.resolveWith((states) {
            // if (isEnable) return Color(0x7094fdf8);
            return Colors.white;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            return 0;
          }),
          overlayColor: WidgetStateColor.resolveWith(
            (states) => Colors.transparent,
          ),
        ),
      ),
    );
  }
}

// ElevatedButton.styleFrom(
// padding: EdgeInsets.only(top: 1),
//
// backgroundColor: Colors.white,
// elevation: 0,
// disabledBackgroundColor: Colors.white,
// side: BorderSide(color: Colors.black),
// ),
