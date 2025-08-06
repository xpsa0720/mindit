import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mindit/task/model/task_model.dart';
import 'package:mindit/user/provider/foreground_provider.dart';

class PenListComponent extends ConsumerStatefulWidget {
  final TaskModel? model;
  final bool check;
  final AnimationController? checkController;
  final Animation<double>? animation;
  final double size;
  final bool boxFill;

  const PenListComponent({
    super.key,
    this.model,
    this.size = 24,
    this.checkController,
    this.animation,
    this.check = false,
    this.boxFill = true,
  });

  @override
  ConsumerState<PenListComponent> createState() => _PenListComponentState();
}

class _PenListComponentState extends ConsumerState<PenListComponent>
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
              width: widget.size * 1.2,
              height: widget.size * 1.2,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("asset/image/pen_checkbox2.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child:
                  widget.checkController == null
                      ? null
                      : Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: PenCheckPainter(
                          size: widget.size,
                          checked: widget.check,
                        ),
                      ),
            ),

            SizedBox(width: widget.size / 3.5),

            SizedBox(
              width: widget.size * 4.5,
              height: widget.size * 1.6,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.model != null ? '${widget.model!.title}' : '게임하기',
                  style: TextStyle(
                    fontFamily: "PenCel",
                    fontWeight: FontWeight.w100,
                    color: Colors.black87,
                    fontSize: widget.size * 1.2,

                    // fontWeight: FontWeight.w200,
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

class PenCheckPainter extends StatelessWidget {
  final bool checked;
  final double size;
  final Duration duration;

  const PenCheckPainter({
    super.key,
    required this.checked,
    this.size = 32,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: checked ? 1.0 : 0.0),
      duration: duration,
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return SizedBox(
          width: size,
          height: size,
          child: Stack(
            children: [
              // 체크 마크 - 그려지는 애니메이션
              ClipRect(
                child: Align(
                  alignment: Alignment.centerLeft,
                  widthFactor: value, // 핵심! 비율만큼만 보여줌 (0.0 ~ 1.0)
                  child: Image.asset(
                    "asset/image/check.png",
                    width: size * 0.8,
                    height: size * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
