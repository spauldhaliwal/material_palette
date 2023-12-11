import 'package:flutter/widgets.dart';

//Copy this CustomPainter code to the Bottom of the File
class LogoPainter extends CustomPainter {
  final Color color;

  LogoPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.3540000, size.height * 0.2460000);
    path_0.lineTo(size.width * 0.07100000, size.height * 0.7390000);
    path_0.lineTo(size.width * 0.09400000, size.height * 0.7540000);
    path_0.cubicTo(
        size.width * 0.3250000,
        size.height * 0.9050000,
        size.width * 0.6360000,
        size.height * 0.8270000,
        size.width * 0.7700000,
        size.height * 0.5860000);
    path_0.lineTo(size.width * 0.7920000, size.height * 0.5470000);
    path_0.cubicTo(
        size.width * 0.8750000,
        size.height * 0.4280000,
        size.width * 0.8460000,
        size.height * 0.2640000,
        size.width * 0.7270000,
        size.height * 0.1800000);
    path_0.lineTo(size.width * 0.7270000, size.height * 0.1800000);
    path_0.cubicTo(
        size.width * 0.6060000,
        size.height * 0.09500000,
        size.width * 0.4390000,
        size.height * 0.1240000,
        size.width * 0.3540000,
        size.height * 0.2460000);
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
