//Copy this CustomPainter code to the Bottom of the File
import 'package:flutter/widgets.dart';

class LogoFullBody extends CustomPainter {
  final Color color;

  LogoFullBody(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = color;
    canvas.drawCircle(Offset(size.width * 0.3565000, size.height * 0.6580000),
        size.width * 0.03850000, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.3565000, size.height * 0.4010000);
    path_1.cubicTo(
        size.width * 0.2855000,
        size.height * 0.4010000,
        size.width * 0.2280000,
        size.height * 0.5160000,
        size.width * 0.2280000,
        size.height * 0.6580000);
    path_1.cubicTo(
        size.width * 0.2280000,
        size.height * 0.8000000,
        size.width * 0.2855000,
        size.height * 0.9150000,
        size.width * 0.3565000,
        size.height * 0.9150000);
    path_1.cubicTo(
        size.width * 0.4275000,
        size.height * 0.9150000,
        size.width * 0.4850000,
        size.height * 0.8000000,
        size.width * 0.4850000,
        size.height * 0.6580000);
    path_1.cubicTo(
        size.width * 0.4850000,
        size.height * 0.5160000,
        size.width * 0.4275000,
        size.height * 0.4010000,
        size.width * 0.3565000,
        size.height * 0.4010000);
    path_1.close();
    path_1.moveTo(size.width * 0.3565000, size.height * 0.8330000);
    path_1.cubicTo(
        size.width * 0.3080000,
        size.height * 0.8330000,
        size.width * 0.2690000,
        size.height * 0.7550000,
        size.width * 0.2690000,
        size.height * 0.6580000);
    path_1.cubicTo(
        size.width * 0.2690000,
        size.height * 0.5610000,
        size.width * 0.3080000,
        size.height * 0.4830000,
        size.width * 0.3565000,
        size.height * 0.4830000);
    path_1.cubicTo(
        size.width * 0.4050000,
        size.height * 0.4830000,
        size.width * 0.4440000,
        size.height * 0.5610000,
        size.width * 0.4440000,
        size.height * 0.6580000);
    path_1.cubicTo(
        size.width * 0.4440000,
        size.height * 0.7540000,
        size.width * 0.4045000,
        size.height * 0.8330000,
        size.width * 0.3565000,
        size.height * 0.8330000);
    path_1.close();

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = color;
    canvas.drawPath(path_1, paint1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
