import 'package:flutter/material.dart';

class TextFiledComponent extends StatelessWidget {
  final TextEditingController textEditingController;
  TextFiledComponent({super.key, required this.textEditingController});
  final defaultBoarder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.black),
  );
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      style: TextStyle(fontSize: 20),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(8),
        filled: true,
        fillColor: Color(0xFFEEEEEE),
        disabledBorder: defaultBoarder,
        enabledBorder: defaultBoarder,
        focusedBorder: defaultBoarder.copyWith(
          borderSide: BorderSide(color: Colors.green),
        ),
        enabled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      cursorColor: Colors.transparent,
    );
  }
}
