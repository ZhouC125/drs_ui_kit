import 'dart:math';
import 'dart:ui' as ui;

import 'package:drs_ui_kit/drs_ui_kit.dart';
import 'package:flutter/material.dart';

class DrsCircleIndicator extends StatefulWidget {
  const DrsCircleIndicator({
    Key? key,
    this.color,
    this.size = 20.0,
    this.lineWidth = 3.0,
    this.duration = 1000,
  }) : super(key: key);

  final Color? color;
  final double size;
  final double lineWidth;
  final int duration;

  @override
  DrsCircleIndicatorState createState() => DrsCircleIndicatorState();
}

class DrsCircleIndicatorState extends State<DrsCircleIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.duration))
      ..addListener(() => setState(() {}))
      ..repeat();
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.linear)));
  }

  @override
  void didUpdateWidget(covariant DrsCircleIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.duration = Duration(milliseconds: widget.duration);
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var value = (_animation1.value) * 2 * pi;
    var paintColor = widget.color ?? barrierColor;
    return Transform(
      transform: Matrix4.identity()..rotateZ(value),
      alignment: FractionalOffset.center,
      child: SizedBox.fromSize(
        size: Size.square(widget.size),
        child: CustomPaint(
          painter: _CirclePaint(color: paintColor, width: widget.lineWidth),
        ),
      ),
    );
  }
}

class _CirclePaint extends CustomPainter {
  final Color color;
  final double width;

  _CirclePaint({required this.color, required this.width});

  final _paint = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    var minLength = min(size.width, size.height);
    _paint.strokeWidth = width;
    _paint.shader = ui.Gradient.sweep(Offset(size.width / 2, size.height / 2),
        [const Color(0x01ffffff), color]);
    if (minLength == size.width) {
      canvas.drawArc(
          Rect.fromLTWH(
              0, (size.height - size.width) / 2, size.width, size.width),
          0,
          pi * 2,
          false,
          _paint);
    } else {
      canvas.drawArc(
          Rect.fromLTWH(
              (size.width - size.height) / 2, 0, size.height, size.height),
          0,
          pi * 2,
          false,
          _paint);
    }
  }
  @override
  bool shouldRepaint(_CirclePaint oldDelegate) {
    return oldDelegate.color != color || oldDelegate.width != width;
  }
}
