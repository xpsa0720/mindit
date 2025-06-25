import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mindit/common/component/calendar_component.dart';
import 'package:mindit/common/component/one_task_calendar_component.dart';
import 'package:mindit/common/component/text_component.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/user/view/detail_in_detail_screen.dart';

import '../../task/provider/task_model_provider.dart';
import '../util/data_util.dart';
import 'Box_component.dart';
import 'check_dialog_component.dart';
import 'delete_button.dart';

class DetailTaskCard extends ConsumerStatefulWidget {
  final TaskModel DBdata;
  const DetailTaskCard({super.key, required this.DBdata});

  @override
  ConsumerState<DetailTaskCard> createState() => _DetailTaskCardState();
}

class _DetailTaskCardState extends ConsumerState<DetailTaskCard> {
  bool detailMode = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {}, child: mainBox());
  }

  mainBox() {
    print(int.parse(widget.DBdata.mainColor).toRadixString(16));
    return BoxComponent(
      // height: 125,
      boxDecoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(int.parse(widget.DBdata.mainColor))],
          stops: [
            0.9 - (widget.DBdata.implementationRate / 100),
            1 + (widget.DBdata.implementationRate / 100),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.black87, width: 2),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          key: PageStorageKey(
            widget.DBdata.title + widget.DBdata.id.toString(),
          ),
          expansionAnimationStyle: AnimationStyle(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          ),
          tilePadding: EdgeInsets.zero,
          collapsedBackgroundColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          childrenPadding: EdgeInsets.zero,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              title(
                '${widget.DBdata.title}',
                DataUtils.PapagoEnglishtoKorea(
                  DataUtils.dayOfWeekToJsonData(
                    widget.DBdata.dayOfWeekModel,
                  ).split(';'),
                ),
              ),
              body(
                '연속 ${widget.DBdata.sequenceDay}일 달성 - 실천율: ${widget.DBdata.implementationRate.toStringAsFixed(1)}%',
              ),
            ],
          ),
          children: [
            SizedBox(height: 10),
            OneTaskCalendarComponent(taskModel: widget.DBdata),
            SizedBox(height: 10),
            Row(children: [TextComponent(text: '실천 시작 시각: ')]),
            SizedBox(height: 5),
            Row(
              children: [
                TextComponent(
                  text: '실천 일 수: ${widget.DBdata.clearDay.length}일',
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: [
                TextComponent(
                  text: '실천하지 못한 일 수: ${widget.DBdata.clearDay.length}일',
                ),
              ],
            ),
            SizedBox(height: 40),
            DeleteButton(callback: DeleteModel, text: '삭제'),
            // TextComponent(text: '실천 못한 일 수: ${}'),
          ],
        ),
      ),
    );
  }

  DeleteModel() {
    CheckDialogComponent(
      title: '정말로 삭제할까요?',
      message: "되돌릴수 없습니다!",
      context: context,
      No_function: () {
        Navigator.pop(context);
      },
      OK_function: () {
        final task_provider = ref.read(TaskModelStateNotifierProvider.notifier);
        task_provider.deleteModel(widget.DBdata);
        Navigator.pop(context);
      },
    );
  }

  title(String text, List<String> weekofDay) {
    return Row(
      children: [
        SizedBox(
          // height: 50,
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          height: 20,
          width: 150,
          child: ListView(
            key: PageStorageKey(
              widget.DBdata.title + widget.DBdata.id.toString(),
            ),
            scrollDirection: Axis.horizontal,
            children:
                weekofDay
                    .map(
                      (e) => Text(
                        e,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }

  body(String text) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22)),
      ],
    );
  }
}
