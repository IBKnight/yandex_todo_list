import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';

class BasicImportanceIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(5.49659, 0);
    path.cubicTo(4.88359, 0, 4.47492, 0.460094, 4.47492, 1.13928);
    path.lineTo(4.47492, 9.09233);
    path.lineTo(4.53622, 10.6771);
    path.lineTo(3.25573, 9.08503);
    path.lineTo(1.70279, 7.41993);
    path.cubicTo(1.51889, 7.22274, 1.2805, 7.07668, 0.973994, 7.07668);
    path.cubicTo(0.422291, 7.07668, 0, 7.50756, 0, 8.13563);
    path.cubicTo(0, 8.42045, 0.108978, 8.69066, 0.320124, 8.92436);
    path.lineTo(4.74056, 13.6714);
    path.cubicTo(4.93127, 13.8758, 5.21734, 14, 5.49659, 14);
    path.cubicTo(5.77585, 14, 6.06192, 13.8758, 6.25263, 13.6714);
    path.lineTo(10.6799, 8.92436);
    path.cubicTo(10.891, 8.69066, 11, 8.42045, 11, 8.13563);
    path.cubicTo(11, 7.50756, 10.5777, 7.07668, 10.026, 7.07668);
    path.cubicTo(9.7195, 7.07668, 9.48111, 7.22274, 9.2904, 7.41993);
    path.lineTo(7.73746, 9.08503);
    path.lineTo(6.45697, 10.6771);
    path.lineTo(6.52508, 9.09233);
    path.lineTo(6.52508, 1.13928);
    path.cubicTo(6.52508, 0.460094, 6.1096, 0, 5.49659, 0);
    path.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = Palette.colorGrayLight.withOpacity(1.0);
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
