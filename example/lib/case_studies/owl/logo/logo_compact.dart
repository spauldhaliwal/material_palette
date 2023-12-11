import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Copy this CustomPainter code to the Bottom of the File
class LogoCompactPainter extends CustomPainter {
  final Color bodyColor;
  final Color beakColor;
  final Color letteringColor;
  final double strokeWidth;
  final Color strokeColor;

  LogoCompactPainter(
    this.bodyColor,
    this.beakColor,
    this.letteringColor, {
    this.strokeWidth = 0,
    this.strokeColor = Colors.transparent,
  });
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5887500, size.height * 0.06375000);
    path_0.cubicTo(
        size.width * 0.4112500,
        size.height * 0.06375000,
        size.width * 0.2675000,
        size.height * 0.2075000,
        size.width * 0.2675000,
        size.height * 0.3850000);
    path_0.cubicTo(
        size.width * 0.2675000,
        size.height * 0.5625000,
        size.width * 0.4125000,
        size.height * 0.7062500,
        size.width * 0.5887500,
        size.height * 0.7062500);
    path_0.cubicTo(
        size.width * 0.7650000,
        size.height * 0.7062500,
        size.width * 0.9100000,
        size.height * 0.5625000,
        size.width * 0.9100000,
        size.height * 0.3850000);
    path_0.cubicTo(
        size.width * 0.9100000,
        size.height * 0.2075000,
        size.width * 0.7662500,
        size.height * 0.06375000,
        size.width * 0.5887500,
        size.height * 0.06375000);
    path_0.close();
    path_0.moveTo(size.width * 0.5887500, size.height * 0.6037500);
    path_0.cubicTo(
        size.width * 0.4675000,
        size.height * 0.6037500,
        size.width * 0.3700000,
        size.height * 0.5062500,
        size.width * 0.3700000,
        size.height * 0.3850000);
    path_0.cubicTo(
        size.width * 0.3700000,
        size.height * 0.2637500,
        size.width * 0.4675000,
        size.height * 0.1662500,
        size.width * 0.5887500,
        size.height * 0.1662500);
    path_0.cubicTo(
        size.width * 0.7100000,
        size.height * 0.1662500,
        size.width * 0.8075000,
        size.height * 0.2637500,
        size.width * 0.8075000,
        size.height * 0.3850000);
    path_0.cubicTo(
        size.width * 0.8075000,
        size.height * 0.5062500,
        size.width * 0.7100000,
        size.height * 0.6037500,
        size.width * 0.5887500,
        size.height * 0.6037500);
    path_0.close();

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = bodyColor;
    canvas.drawPath(path_0, paint0Fill);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = beakColor;
    canvas.drawRect(
        Rect.fromLTWH(size.width * 0.4700000, size.height * 0.2675000,
            size.width * 0.2362500, size.height * 0.2362500),
        paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.5887500, size.height * 0.2362500);
    path_2.lineTo(size.width * 0.7387500, size.height * 0.3862500);
    path_2.lineTo(size.width * 0.5887500, size.height * 0.5362500);
    path_2.lineTo(size.width * 0.4387500, size.height * 0.3862500);
    path_2.lineTo(size.width * 0.5887500, size.height * 0.2362500);
    path_2.moveTo(size.width * 0.5887500, size.height * 0.2000000);
    path_2.lineTo(size.width * 0.4037500, size.height * 0.3850000);
    path_2.lineTo(size.width * 0.5887500, size.height * 0.5700000);
    path_2.lineTo(size.width * 0.7737500, size.height * 0.3850000);
    path_2.lineTo(size.width * 0.5887500, size.height * 0.2000000);
    path_2.lineTo(size.width * 0.5887500, size.height * 0.2000000);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = letteringColor;
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.3062500, size.height * 0.9237500);
    path_3.cubicTo(
        size.width * 0.2400000,
        size.height * 0.9237500,
        size.width * 0.1737500,
        size.height * 0.9062500,
        size.width * 0.1162500,
        size.height * 0.8712500);
    path_3.lineTo(size.width * 0.1075000, size.height * 0.8662500);
    path_3.lineTo(size.width * 0.3137500, size.height * 0.4687500);
    path_3.cubicTo(
        size.width * 0.3512500,
        size.height * 0.4100000,
        size.width * 0.4150000,
        size.height * 0.3750000,
        size.width * 0.4850000,
        size.height * 0.3750000);
    path_3.cubicTo(
        size.width * 0.5237500,
        size.height * 0.3750000,
        size.width * 0.5625000,
        size.height * 0.3862500,
        size.width * 0.5950000,
        size.height * 0.4075000);
    path_3.cubicTo(
        size.width * 0.6875000,
        size.height * 0.4675000,
        size.width * 0.7150000,
        size.height * 0.5912500,
        size.width * 0.6562500,
        size.height * 0.6850000);
    path_3.lineTo(size.width * 0.6387500, size.height * 0.7187500);
    path_3.cubicTo(
        size.width * 0.5762500,
        size.height * 0.8450000,
        size.width * 0.4475000,
        size.height * 0.9237500,
        size.width * 0.3062500,
        size.height * 0.9237500);
    path_3.cubicTo(
        size.width * 0.3062500,
        size.height * 0.9237500,
        size.width * 0.3062500,
        size.height * 0.9237500,
        size.width * 0.3062500,
        size.height * 0.9237500);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = letteringColor;
    canvas.drawPath(path_3, paint3Fill);

    Path path_4 = Path();
    path_4.moveTo(size.width * 0.4850000, size.height * 0.3875000);
    path_4.cubicTo(
        size.width * 0.5212500,
        size.height * 0.3875000,
        size.width * 0.5575000,
        size.height * 0.3975000,
        size.width * 0.5887500,
        size.height * 0.4175000);
    path_4.cubicTo(
        size.width * 0.6762500,
        size.height * 0.4737500,
        size.width * 0.7012500,
        size.height * 0.5900000,
        size.width * 0.6462500,
        size.height * 0.6775000);
    path_4.lineTo(size.width * 0.6450000, size.height * 0.6787500);
    path_4.lineTo(size.width * 0.6450000, size.height * 0.6800000);
    path_4.lineTo(size.width * 0.6287500, size.height * 0.7125000);
    path_4.cubicTo(
        size.width * 0.5675000,
        size.height * 0.8350000,
        size.width * 0.4437500,
        size.height * 0.9112500,
        size.width * 0.3062500,
        size.height * 0.9112500);
    path_4.cubicTo(
        size.width * 0.2425000,
        size.height * 0.9112500,
        size.width * 0.1800000,
        size.height * 0.8937500,
        size.width * 0.1237500,
        size.height * 0.8612500);
    path_4.lineTo(size.width * 0.3237500, size.height * 0.4762500);
    path_4.cubicTo(
        size.width * 0.3600000,
        size.height * 0.4200000,
        size.width * 0.4200000,
        size.height * 0.3875000,
        size.width * 0.4850000,
        size.height * 0.3875000);
    path_4.moveTo(size.width * 0.4850000, size.height * 0.3625000);
    path_4.cubicTo(
        size.width * 0.4137500,
        size.height * 0.3625000,
        size.width * 0.3437500,
        size.height * 0.3975000,
        size.width * 0.3025000,
        size.height * 0.4625000);
    path_4.lineTo(size.width * 0.09000000, size.height * 0.8700000);
    path_4.lineTo(size.width * 0.1087500, size.height * 0.8812500);
    path_4.cubicTo(
        size.width * 0.1700000,
        size.height * 0.9175000,
        size.width * 0.2387500,
        size.height * 0.9350000,
        size.width * 0.3050000,
        size.height * 0.9350000);
    path_4.cubicTo(
        size.width * 0.4462500,
        size.height * 0.9350000,
        size.width * 0.5825000,
        size.height * 0.8575000,
        size.width * 0.6500000,
        size.height * 0.7225000);
    path_4.lineTo(size.width * 0.6662500, size.height * 0.6900000);
    path_4.cubicTo(
        size.width * 0.7287500,
        size.height * 0.5912500,
        size.width * 0.7000000,
        size.height * 0.4600000,
        size.width * 0.6012500,
        size.height * 0.3962500);
    path_4.cubicTo(
        size.width * 0.5662500,
        size.height * 0.3737500,
        size.width * 0.5250000,
        size.height * 0.3625000,
        size.width * 0.4850000,
        size.height * 0.3625000);
    path_4.lineTo(size.width * 0.4850000, size.height * 0.3625000);
    path_4.close();

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = letteringColor;
    canvas.drawPath(path_4, paint4Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
