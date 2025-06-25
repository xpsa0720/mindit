import 'package:flutter/material.dart';
import 'package:mindit/common/component/text_component.dart';

Future<void> CheckDialogComponent({
  required String title,
  required String message,
  required BuildContext context,
  required VoidCallback OK_function,
  required VoidCallback No_function,
}) async {
  return showDialog<void>(
    context: context, // 다이얼로그를 띄울 context
    // barrierDismissible: false, // 바깥 영역 터치로 닫히지 않음
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),

        backgroundColor: Colors.white,
        title: TextComponent(text: title),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[TextComponent(text: message, fontsize: 15)],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: TextComponent(text: '아니오', fontsize: 13),
            onPressed: No_function,
          ),
          TextButton(
            child: TextComponent(text: '네', fontsize: 13),
            onPressed: OK_function,
          ),
        ],
      );
    },
  );
}
