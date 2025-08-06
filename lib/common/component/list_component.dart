import 'package:animated_check/animated_check.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/user/provider/foreground_provider.dart';

class ListComponent extends ConsumerStatefulWidget {
  final TaskModel? model;
  final bool check;
  final AnimationController? checkController;
  final Animation<double>? animation;
  final double size;
  final bool boxFill;

  const ListComponent({
    super.key,
    this.model,
    this.size = 24,
    this.checkController,
    this.animation,
    this.check = false,
    this.boxFill = true,
  });

  @override
  ConsumerState<ListComponent> createState() => _ListComponentState();
}

class _ListComponentState extends ConsumerState<ListComponent>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  bool get wantKeepAlive => true;
  bool DataLoding = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (widget.checkController != null) {
      if (widget.check) {
        widget.checkController!.forward();
      } else {
        widget.checkController!.reverse();
      }
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: GestureDetector(
        onTap: widget.checkController == null ? null : onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.boxFill ? Color(0xFFF0F0F0) : Colors.transparent,
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
            SizedBox(width: widget.size / 4),

            SizedBox(
              width: widget.size * 5,
              height: widget.size * 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.model != null ? '${widget.model!.title}' : '게임하기',
                  style: TextStyle(
                    fontSize: widget.size * 1.2,

                    fontWeight: FontWeight.w200,
                  ),
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
      if (!widget.check) {
        if (widget.model != null) {
          ref
              .read(ForegroundServiceProvider.notifier)
              .complateTask(widget.model!);
        }
      } else {
        if (widget.model != null) {
          widget.checkController!.reverse();
          ref
              .read(ForegroundServiceProvider.notifier)
              .cancelTask(widget.model!);
        }
      }
    });
  }
}
