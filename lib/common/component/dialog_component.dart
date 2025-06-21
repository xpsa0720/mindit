import 'package:flutter/material.dart';
import 'package:mindit/common/component/text_component.dart';

Future<void> GetNameDialogComponent(
  BuildContext context,
  TextEditingController textController,
  VoidCallback OK_function,
  VoidCallback No_function,
) async {
  return showDialog<void>(
    context: context, // 다이얼로그를 띄울 context
    barrierDismissible: false, // 바깥 영역 터치로 닫히지 않음
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        backgroundColor: Colors.white,
        title: TextComponent(text: "환영합니다!"),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextComponent(
                text: "안녕하세요! Mindit을 사용하시기 전에\n사용하실 이름을 설정해 주세요!",
                fontsize: 15,
              ),
              TextFormField(
                controller: textController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hoverColor: Colors.black,
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green, // 포커스(입력 중) 상태일 때 밑줄 색
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: TextComponent(text: '다음에 할게요', fontsize: 13),
            onPressed: No_function,
          ),
          TextButton(
            child: TextComponent(text: '확인', fontsize: 13),
            onPressed: OK_function,
          ),
        ],
      );
    },
  );
}
