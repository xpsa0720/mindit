import 'package:flutter/material.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontsize;
  const TextComponent({
    super.key,
    required this.text,
    this.color,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: fontsize == null ? 20 : fontsize,
        color: color == null ? Colors.black : color,
      ),
    );
  }
}
