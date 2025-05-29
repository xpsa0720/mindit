import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/task/model/day_of_week_model.dart';
import 'package:mindit/task/model/task_model.dart';

import '../../common/component/text_filed_component.dart';
import '../../common/data/color.dart';
import '../../common/data/sqlite.dart';
import '../../sqlite/provider/db_provider.dart';
import '../../task/util/dummy_data.dart';

class DataPlusScreen extends ConsumerStatefulWidget {
  const DataPlusScreen({super.key});

  @override
  ConsumerState<DataPlusScreen> createState() => _DataPlusScreenState();
}

class _DataPlusScreenState extends ConsumerState<DataPlusScreen> {
  List<String> DayOfWeek_list = ['월', '화', '수', '목', '금', '토', '일'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptorController = TextEditingController();
  List<bool> DayOfWeek_bool_list = List.generate(7, (index) => false);
  bool isenableYesButton = false;
  bool isenableNoButton = true;
  int seletedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxComponent(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Row(children: [renderText('실천 내용')]),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 20),
                child: TextFiledComponent(
                  textEditingController: titleController,
                ),
              ),
              SizedBox(height: 32),
              Row(children: [renderText('실천 설명')]),
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 20),
                child: TextFiledComponent(
                  textEditingController: descriptorController,
                ),
              ),
              SizedBox(height: 32),
              SelectDayWidget(),
              SelectWeekDayWidget(),

              SizedBox(height: 38),
              AleramWidget(),
              SizedBox(height: 32),
              ColorWidget(),
              SizedBox(height: 16),

              CreateButton(text: '생성', callback: CreateTaskModel),
            ],
          ),
          width: double.infinity,
        ),
      ],
    );
  }

  CreateTaskModel() {
    final state = ref.watch(dbHelperProvider);
    state.InsertTaskModel(
      model: TaskModel(
        title: titleController.text,
        dayOfWeekModel: DayOfWeekModel(
          dayOfWeek: DataUtils.generateDayOfWeekList(DayOfWeek_bool_list),
        ),
        descriptor: descriptorController.text,
        mainColor: PASTEL_COLORS_INT[seletedColor].toString(),
      ),
      table: TABLE_NAME,
    );
  }

  ColorWidget() {
    return Column(
      children: [
        Row(children: [renderText('메인 색상')]),
        SizedBox(height: 8),
        Row(
          children: List.generate(PASTEL_COLORS.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  seletedColor = index;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                color: PASTEL_COLORS[index],
                child: seletedColor == index ? Icon(Icons.check) : null,
              ),
            );
          }),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  AleramWidget() {
    return Row(
      children: [
        renderText('알림 허용'),
        renderButton(
          text: '예',
          callback: () {
            isenableYesButton = true;
            isenableNoButton = false;
            setState(() {});
          },
          enableColor: isenableYesButton,
        ),
        renderButton(
          text: '아니오',
          callback: () {
            isenableYesButton = false;
            isenableNoButton = true;
            setState(() {});
          },
          enableColor: isenableNoButton,
        ),
      ],
    );
  }

  SelectDayWidget() {
    return Row(
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
    );
  }

  SelectWeekDayWidget() {
    return Row(
      children: List.generate(7, (index) {
        return renderDayOfWeek(
          isEnable: DayOfWeek_bool_list[index],
          text: DayOfWeek_list[index],
          callback: () {
            setState(() {
              DayOfWeek_bool_list[index] = !DayOfWeek_bool_list[index];
            });
          },
        );
      }),
    );
  }

  Widget renderText(text) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
    );
  }

  Widget renderButton({
    required String text,
    required VoidCallback callback,
    bool? enableColor,
  }) {
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
            return enableColor == null
                ? Colors.white
                : !enableColor
                ? Colors.white
                : Colors.black12;
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

  CreateButton({required String text, required VoidCallback callback}) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ElevatedButton(
        onPressed: callback,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        style: ButtonStyle(
          minimumSize: WidgetStateProperty.resolveWith((states) {
            return Size(double.infinity, 50);
          }),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          backgroundColor: WidgetStateColor.resolveWith((states) {
            return Colors.white;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            return 0;
          }),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(color: Colors.black, width: 1),
          ),
          overlayColor: WidgetStateColor.resolveWith(
            (states) => Color(0xFFd1d1d1),
          ),
        ),
      ),
    );
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
