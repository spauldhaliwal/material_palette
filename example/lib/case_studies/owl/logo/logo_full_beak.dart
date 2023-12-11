//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/widgets.dart';

class LogoFullBeak extends CustomPainter {
  final Color color;

  LogoFullBeak(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4025000, size.height * 0.2690000);
    path_0.lineTo(size.width * 0.3855000, size.height * 0.5280000);
    path_0.lineTo(size.width * 0.4640000, size.height * 0.3920000);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawPath(path_0, paint0Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
