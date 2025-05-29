import 'package:flutter/material.dart';
import 'package:mindit/task/model/task_model.dart';

import '../util/data_util.dart';
import 'Box_component.dart';

class DetailTaskCard extends StatelessWidget {
  final TaskModel DBdata;
  const DetailTaskCard({super.key, required this.DBdata});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: BoxComponent(
        child: Column(
          children: [
            title(
              '${DBdata.title}',
              DataUtils.PapagoEnglishtoKorea(
                DataUtils.dayOfWeekToJsonData(DBdata.dayOfWeekModel).split(';'),
              ),
            ),
            body(
              '연속 ${DBdata.sequenceDay}일 달성 - 실천율: ${DBdata.implementationRate.toStringAsFixed(1)}%',
            ),
          ],
        ),
        height: 105,
        boxDecoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(int.parse(DBdata.mainColor))],
            stops: [
              0.9 - (DBdata.implementationRate / 100),
              1 + (DBdata.implementationRate / 100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black54, width: 2),
        ),
      ),
    );
  }

  title(String text, List<String> weekofDay) {
    return Row(
      children: [
        SizedBox(
          height: 50,
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
        Text(text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24)),
      ],
    );
  }
}
