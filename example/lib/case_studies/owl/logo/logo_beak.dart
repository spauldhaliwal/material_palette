import 'package:flutter/widgets.dart';

//Copy this CustomPainter code to the Bottom of the File
class LogoBeakPainter extends CustomPainter {
  final Color color;

  LogoBeakPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.8050000, size.height * 0.3090000);
    path_0.lineTo(size.width * 0.7720000, size.height * 0.5680000);
    path_0.lineTo(size.width * 0.9280000, size.height * 0.4320000);
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
