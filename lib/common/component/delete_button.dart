import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback callback;
  final String text;

  const DeleteButton({super.key, required this.callback, required this.text});

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
            color: Colors.red,
          ),
        ),

        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          minimumSize: WidgetStateProperty.resolveWith((states) {
            return Size(60, 35);
          }),
          backgroundColor: WidgetStateColor.resolveWith((states) {
            return Colors.transparent;
          }),
          elevation: WidgetStateProperty.resolveWith((states) {
            return 0;
          }),
          side: WidgetStateProperty.resolveWith(
            (states) => BorderSide(color: Colors.red),
          ),
          overlayColor: WidgetStateColor.resolveWith(
            (states) => Color(0xFFd1d1d1),
          ),
        ),
      ),
    );
  }
}
