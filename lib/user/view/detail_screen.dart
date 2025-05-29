import 'package:flutter/material.dart';
import 'package:mindit/common/component/Box_component.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 10,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: BoxComponent(
            child: Column(
              children: [
                title('무여', '월 . 화 . 수 . 목 . 금'),
                body('연속 4일 달성 - 실천율: 40%'),
              ],
            ),
            height: 105,
            boxDecoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.purple],
                stops: [0.3, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black54, width: 2),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: 8);
      },
    );
  }

  title(String text, String weekofDay) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30)),
        SizedBox(width: 10),
        Text(
          weekofDay,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ],
    );
  }

  body(String text) {
    return Row(
      children: [
        Text(text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
      ],
    );
  }
}
