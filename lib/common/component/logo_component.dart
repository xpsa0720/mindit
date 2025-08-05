import 'package:flutter/material.dart';

class LogoComponent extends StatelessWidget {
  final double size;
  const LogoComponent({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text(
          'Mindit',
          style: TextStyle(
            fontFamily: 'Manjari',
            fontWeight: FontWeight.w500,
            fontSize: size,
          ),
        ),
      ],
    );
  }
}
