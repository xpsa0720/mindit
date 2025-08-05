import 'package:flutter/material.dart';

class BoxComponent extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final BoxDecoration? boxDecoration;
  final EdgeInsets? padding;
  final EdgeInsets? boaderPadding;
  final bool shadow;
  const BoxComponent({
    super.key,
    required this.child,
    this.width,
    this.boaderPadding,
    this.height,
    this.boxDecoration,
    this.padding,
    this.shadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: boaderPadding == null ? EdgeInsets.all(8.0) : boaderPadding!,
      child: Container(
        width: width,
        height: height,
        child: Padding(
          padding: padding == null ? EdgeInsets.all(8.0) : padding!,
          child: child,
        ),
        decoration:
            boxDecoration == null
                ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black.withAlpha(95),
                    width: 1,
                  ),
                  boxShadow: [
                    if (shadow)
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 1,
                        offset: Offset(2, 4),
                      ),
                  ],
                )
                : boxDecoration!.copyWith(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 1,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
      ),
    );
  }
}
