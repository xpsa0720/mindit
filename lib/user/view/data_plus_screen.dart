import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/common/component/Box_component.dart';
import 'package:mindit/common/util/data_util.dart';
import 'package:mindit/task/model/day_of_week_model.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/task/provider/task_model_provider.dart';
import 'package:mindit/user/provider/user_information_provider.dart';

import '../../common/component/text_component.dart';
import '../../common/component/text_filed_component.dart';
import '../../common/data/color.dart';
import '../../common/data/sqlite.dart';
import '../../sqlite/provider/db_provider.dart';
import '../../task/util/dummy_data.dart';
import '../provider/prefs_provider.dart';

class DataPlusScreen extends ConsumerStatefulWidget {
  const DataPlusScreen({super.key});
  static String get routeFullPath => '/plus';

  static String get routePath => 'plus';

  @override
  ConsumerState<DataPlusScreen> createState() => _DataPlusScreenState();
}

class _DataPlusScreenState extends ConsumerState<DataPlusScreen>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;

  List<String> DayOfWeek_list = ['월', '화', '수', '목', '금', '토', '일'];
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptorController = TextEditingController();
  List<bool> DayOfWeek_bool_list = List.generate(7, (index) => false);
  bool isenableYesButton = false;
  bool isenableNoButton = true;
  int seletedColor = 0;
  bool errorDayOfWeek = false;
  bool errorTitle = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 900,
      child: ListView(
        children: [
          BoxComponent(
            width: double.infinity,

            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Row(children: [TextComponent(text: '실천 내용')]),
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 20),
                  child: TextFiledComponent(
                    textEditingController: titleController,
                  ),
                ),
                TextComponent(
                  text: '*내용을 입력해 주세요!*',
                  color: errorTitle ? Colors.red : Colors.transparent,
                ),
                SizedBox(height: 10),
                Row(children: [TextComponent(text: '실천 설명')]),
                Padding(
                  padding: const EdgeInsets.only(top: 5, right: 20),
                  child: TextFiledComponent(
                    textEditingController: descriptorController,
                  ),
                ),
                SizedBox(height: 32),
                SelectDayWidget(),
                SelectWeekDayWidget(),
                TextComponent(
                  text: '*활동 날짜를 설정해 주세요!*',
                  color: errorDayOfWeek ? Colors.red : Colors.transparent,
                ),

                SizedBox(height: 16),
                ColorWidget(),
                SizedBox(height: 16),

                CreateButton(text: '생성', callback: CreateTaskModel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CreateTaskModel() async {
    if (titleController.text.isEmpty) {
      setState(() {
        errorTitle = true;
      });
      return;
    } else {
      setState(() {
        errorTitle = false;
      });
    }
    bool iserror = true;
    List.generate(DayOfWeek_bool_list.length, (index) {
      if (DayOfWeek_bool_list[index] == true) iserror = false;
    });

    if (iserror) {
      errorDayOfWeek = true;
      setState(() {});
      return;
    } else {
      errorDayOfWeek = false;
      setState(() {});
    }

    final task_provider = ref.read(TaskModelStateNotifierProvider.notifier);
    final model = TaskModel(
      title: titleController.text,
      dayOfWeekModel: DayOfWeekModel(
        dayOfWeek: DataUtils.generateDayOfWeekList(DayOfWeek_bool_list),
      ),
      descriptor: descriptorController.text,
      mainColor: PASTEL_COLORS_INT[seletedColor].toString(),
    );
    InitContent();
    final return_id = task_provider.addlist(model);
    return return_id;
  }

  InitContent() {
    titleController.text = "";
    descriptorController.text = "";
    DayOfWeek_bool_list = List.generate(7, (index) => false);
    isenableYesButton = false;
    isenableNoButton = true;
    seletedColor = 0;
    errorDayOfWeek = false;
    errorTitle = false;
  }

  ColorWidget() {
    return Column(
      children: [
        Row(children: [TextComponent(text: '메인 색상')]),
        SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(PASTEL_COLORS.length, (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    seletedColor = index;
                  });
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: PASTEL_COLORS[index],
                  child: seletedColor == index ? Icon(Icons.check) : null,
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  AleramWidget() {
    return Row(
      children: [
        TextComponent(text: '알림 허용'),
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
        TextComponent(text: '활동 날짜'),
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
