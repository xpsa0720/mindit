import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final bool enableColor;
  final VoidCallback callback;
  final String text;
  const ButtonComponent({
    super.key,
    required this.enableColor,
    required this.callback,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
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
}
