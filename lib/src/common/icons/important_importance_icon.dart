import 'package:flutter/material.dart';
import 'package:yandex_todo_list/src/common/palette.dart';

class ImportantImportanceIcon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(1.69505, 11.0403);
    path.cubicTo(2.5223, 11.0403, 2.97648, 10.5301, 3.00081, 9.65186);
    path.lineTo(3.1468, 1.84004);
    path.cubicTo(3.15491, 1.72295, 3.16302, 1.59749, 3.16302, 1.50549);
    path.cubicTo(3.16302, 0.560376, 2.58719, 0, 1.69505, 0);
    path.cubicTo(0.80292, 0, 0.218978, 0.560376, 0.218978, 1.50549);
    path.cubicTo(0.218978, 1.59749, 0.227088, 1.72295, 0.227088, 1.84004);
    path.lineTo(0.381184, 9.65186);
    path.cubicTo(0.413625, 10.5301, 0.859692, 11.0403, 1.69505, 11.0403);
    path.close();
    path.moveTo(8.32117, 11.0403);
    path.cubicTo(9.14842, 11.0403, 9.61071, 10.5301, 9.63504, 9.65186);
    path.lineTo(9.78102, 1.84004);
    path.cubicTo(9.78102, 1.72295, 9.78913, 1.59749, 9.78913, 1.50549);
    path.cubicTo(9.78913, 0.560376, 9.22141, 0, 8.32117, 0);
    path.cubicTo(7.42904, 0, 6.84509, 0.560376, 6.84509, 1.50549);
    path.cubicTo(6.84509, 1.59749, 6.8532, 1.72295, 6.86131, 1.84004);
    path.lineTo(7.01541, 9.65186);
    path.cubicTo(7.03974, 10.5301, 7.48581, 11.0403, 8.32117, 11.0403);
    path.close();
    path.moveTo(1.68694, 16);
    path.cubicTo(2.61963, 16, 3.37388, 15.264, 3.37388, 14.3356);
    path.cubicTo(3.37388, 13.4072, 2.61963, 12.6628, 1.68694, 12.6628);
    path.cubicTo(0.754258, 12.6628, 0, 13.4072, 0, 14.3356);
    path.cubicTo(0, 15.264, 0.754258, 16, 1.68694, 16);
    path.close();
    path.moveTo(8.32117, 16);
    path.cubicTo(9.24574, 16, 10, 15.264, 10, 14.3356);
    path.cubicTo(10, 13.4072, 9.24574, 12.6628, 8.32117, 12.6628);
    path.cubicTo(7.38848, 12.6628, 6.62612, 13.4072, 6.62612, 14.3356);
    path.cubicTo(6.62612, 15.264, 7.38848, 16, 8.32117, 16);
    path.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = Palette.redLight.withOpacity(1.0);
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
