import 'package:flutter/material.dart';

import '../data/color.dart';

class ListComponent extends StatefulWidget {
  const ListComponent({super.key});

  @override
  State<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent> {
  bool isClear = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: isClear ? CLEAR_COLOR : Colors.white,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: Text('게임하기', style: TextStyle(fontSize: 30))),
        ),
      ),
    );
  }

  onTap() {
    setState(() {
      isClear = !isClear;
    });
  }
}
