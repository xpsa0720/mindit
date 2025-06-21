import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:mindit/task/model/task_model.dart';

import '../data/color.dart';

class ListComponent extends StatefulWidget {
  final TaskModel? model;

  final AnimationController? checkController;
  final Animation<double>? animation;
  const ListComponent({
    super.key,
    this.model,
    this.checkController,
    this.animation,
  });

  @override
  State<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends State<ListComponent>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;
  bool isClear = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: widget.checkController == null ? null : onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Color(0xFFDEDEDE),
                border: Border.all(color: Colors.black),
              ),
              child:
                  widget.checkController == null
                      ? null
                      : AnimatedCheck(
                        progress: widget.animation!,
                        size: 30,
                        color: Colors.black,
                      ),
            ),
            SizedBox(width: 6),

            SizedBox(
              width: 130,
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.model != null ? '${widget.model!.title}' : '게임하기',
                  // '게임하기aaaaaaaaa',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w200),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTap() {
    setState(() {
      isClear = !isClear;
      if (isClear)
        widget.checkController!.forward();
      else
        widget.checkController!.reverse();
    });
  }
}
