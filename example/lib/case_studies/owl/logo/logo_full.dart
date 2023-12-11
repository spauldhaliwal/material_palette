import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//Copy this CustomPainter code to the Bottom of the File
class OwlLogoFull extends CustomPainter {
  final Color body;
  final Color beak;
  final Color lettering;
  final Color beakStroke;
  final Color bodyStroke;
  final double strokeWidth;

  OwlLogoFull(
    this.body,
    this.beak,
    this.lettering, {
    this.beakStroke = Colors.transparent,
    this.bodyStroke = Colors.transparent,
    this.strokeWidth = 1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.4025000, size.height * 0.2690000);
    path_0.lineTo(size.width * 0.3855000, size.height * 0.5280000);
    path_0.lineTo(size.width * 0.4640000, size.height * 0.3920000);
    path_0.close();

    Paint paint0Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01000000 * strokeWidth;
    paint0Stroke.color = beakStroke;
    canvas.drawPath(path_0, paint0Stroke);

    Paint paint0Fill = Paint()..style = PaintingStyle.fill;
    paint0Fill.color = body;
    canvas.drawPath(path_0, paint0Fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.1765000, size.height * 0.2060000);
    path_1.lineTo(size.width * 0.03500000, size.height * 0.6990000);
    path_1.lineTo(size.width * 0.04650000, size.height * 0.7140000);
    path_1.cubicTo(
        size.width * 0.1625000,
        size.height * 0.8650000,
        size.width * 0.3180000,
        size.height * 0.7870000,
        size.width * 0.3850000,
        size.height * 0.5460000);
    path_1.lineTo(size.width * 0.3960000, size.height * 0.5070000);
    path_1.cubicTo(
        size.width * 0.4375000,
        size.height * 0.3880000,
        size.width * 0.4230000,
        size.height * 0.2240000,
        size.width * 0.3635000,
        size.height * 0.1400000);
    path_1.lineTo(size.width * 0.3635000, size.height * 0.1400000);
    path_1.cubicTo(
        size.width * 0.3030000,
        size.height * 0.05500000,
        size.width * 0.2190000,
        size.height * 0.08400000,
        size.width * 0.1765000,
        size.height * 0.2060000);
    path_1.close();

    Paint paint1Stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.01000000 * strokeWidth;
    paint1Stroke.color = bodyStroke;
    canvas.drawPath(path_1, paint1Stroke);

    Paint paint1Fill = Paint()..style = PaintingStyle.fill;
    paint1Fill.color = beak;
    canvas.drawPath(path_1, paint1Fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.7535000, size.height * 0.4210000);
    path_2.lineTo(size.width * 0.7235000, size.height * 0.4210000);
    path_2.cubicTo(
        size.width * 0.7180000,
        size.height * 0.4210000,
        size.width * 0.7145000,
        size.height * 0.4260000,
        size.width * 0.7140000,
        size.height * 0.4350000);
    path_2.lineTo(size.width * 0.6860000, size.height * 0.7420000);
    path_2.lineTo(size.width * 0.6550000, size.height * 0.5440000);
    path_2.cubicTo(
        size.width * 0.6545000,
        size.height * 0.5400000,
        size.width * 0.6535000,
        size.height * 0.5370000,
        size.width * 0.6520000,
        size.height * 0.5330000);
    path_2.cubicTo(
        size.width * 0.6505000,
        size.height * 0.5290000,
        size.width * 0.6480000,
        size.height * 0.5270000,
        size.width * 0.6440000,
        size.height * 0.5270000);
    path_2.lineTo(size.width * 0.6255000, size.height * 0.5270000);
    path_2.cubicTo(
        size.width * 0.6220000,
        size.height * 0.5270000,
        size.width * 0.6195000,
        size.height * 0.5290000,
        size.width * 0.6180000,
        size.height * 0.5330000);
    path_2.cubicTo(
        size.width * 0.6165000,
        size.height * 0.5370000,
        size.width * 0.6150000,
        size.height * 0.5410000,
        size.width * 0.6145000,
        size.height * 0.5440000);
    path_2.lineTo(size.width * 0.5840000, size.height * 0.7430000);
    path_2.lineTo(size.width * 0.5560000, size.height * 0.4350000);
    path_2.cubicTo(
        size.width * 0.5555000,
        size.height * 0.4260000,
        size.width * 0.5520000,
        size.height * 0.4210000,
        size.width * 0.5465000,
        size.height * 0.4210000);
    path_2.lineTo(size.width * 0.5165000, size.height * 0.4210000);
    path_2.cubicTo(
        size.width * 0.5145000,
        size.height * 0.4210000,
        size.width * 0.5130000,
        size.height * 0.4220000,
        size.width * 0.5115000,
        size.height * 0.4250000);
    path_2.cubicTo(
        size.width * 0.5100000,
        size.height * 0.4280000,
        size.width * 0.5095000,
        size.height * 0.4310000,
        size.width * 0.5095000,
        size.height * 0.4350000);
    path_2.cubicTo(
        size.width * 0.5095000,
        size.height * 0.4350000,
        size.width * 0.5095000,
        size.height * 0.4360000,
        size.width * 0.5095000,
        size.height * 0.4370000);
    path_2.cubicTo(
        size.width * 0.5095000,
        size.height * 0.4380000,
        size.width * 0.5095000,
        size.height * 0.4390000,
        size.width * 0.5095000,
        size.height * 0.4400000);
    path_2.lineTo(size.width * 0.5500000, size.height * 0.8760000);
    path_2.cubicTo(
        size.width * 0.5505000,
        size.height * 0.8820000,
        size.width * 0.5520000,
        size.height * 0.8870000,
        size.width * 0.5540000,
        size.height * 0.8910000);
    path_2.cubicTo(
        size.width * 0.5560000,
        size.height * 0.8950000,
        size.width * 0.5585000,
        size.height * 0.8970000,
        size.width * 0.5620000,
        size.height * 0.8970000);
    path_2.lineTo(size.width * 0.5850000, size.height * 0.8970000);
    path_2.cubicTo(
        size.width * 0.5885000,
        size.height * 0.8970000,
        size.width * 0.5915000,
        size.height * 0.8950000,
        size.width * 0.5930000,
        size.height * 0.8920000);
    path_2.cubicTo(
        size.width * 0.5950000,
        size.height * 0.8880000,
        size.width * 0.5960000,
        size.height * 0.8850000,
        size.width * 0.5970000,
        size.height * 0.8800000);
    path_2.lineTo(size.width * 0.6350000, size.height * 0.6530000);
    path_2.lineTo(size.width * 0.6730000, size.height * 0.8800000);
    path_2.cubicTo(
        size.width * 0.6735000,
        size.height * 0.8840000,
        size.width * 0.6750000,
        size.height * 0.8880000,
        size.width * 0.6770000,
        size.height * 0.8920000);
    path_2.cubicTo(
        size.width * 0.6790000,
        size.height * 0.8960000,
        size.width * 0.6815000,
        size.height * 0.8970000,
        size.width * 0.6850000,
        size.height * 0.8970000);
    path_2.lineTo(size.width * 0.7080000, size.height * 0.8970000);
    path_2.cubicTo(
        size.width * 0.7115000,
        size.height * 0.8970000,
        size.width * 0.7140000,
        size.height * 0.8950000,
        size.width * 0.7160000,
        size.height * 0.8910000);
    path_2.cubicTo(
        size.width * 0.7180000,
        size.height * 0.8870000,
        size.width * 0.7195000,
        size.height * 0.8820000,
        size.width * 0.7195000,
        size.height * 0.8760000);
    path_2.lineTo(size.width * 0.7600000, size.height * 0.4400000);
    path_2.cubicTo(
        size.width * 0.7600000,
        size.height * 0.4390000,
        size.width * 0.7605000,
        size.height * 0.4380000,
        size.width * 0.7605000,
        size.height * 0.4370000);
    path_2.cubicTo(
        size.width * 0.7605000,
        size.height * 0.4360000,
        size.width * 0.7605000,
        size.height * 0.4350000,
        size.width * 0.7605000,
        size.height * 0.4350000);
    path_2.cubicTo(
        size.width * 0.7605000,
        size.height * 0.4310000,
        size.width * 0.7600000,
        size.height * 0.4280000,
        size.width * 0.7585000,
        size.height * 0.4250000);
    path_2.cubicTo(
        size.width * 0.7570000,
        size.height * 0.4220000,
        size.width * 0.7550000,
        size.height * 0.4210000,
        size.width * 0.7535000,
        size.height * 0.4210000);
    path_2.close();

    Paint paint2Fill = Paint()..style = PaintingStyle.fill;
    paint2Fill.color = lettering;
    canvas.drawPath(path_2, paint2Fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.9620000, size.height * 0.8210000);
    path_3.cubicTo(
        size.width * 0.9605000,
        size.height * 0.8180000,
        size.width * 0.9585000,
        size.height * 0.8160000,
        size.width * 0.9560000,
        size.height * 0.8160000);
    path_3.lineTo(size.width * 0.8480000, size.height * 0.8160000);
    path_3.lineTo(size.width * 0.8480000, size.height * 0.4370000);
    path_3.cubicTo(
        size.width * 0.8480000,
        size.height * 0.4320000,
        size.width * 0.8470000,
        size.height * 0.4290000,
        size.width * 0.8455000,
        size.height * 0.4250000);
    path_3.cubicTo(
        size.width * 0.8440000,
        size.height * 0.4220000,
        size.width * 0.8420000,
        size.height * 0.4200000,
        size.width * 0.8395000,
        size.height * 0.4200000);
    path_3.lineTo(size.width * 0.8080000, size.height * 0.4200000);
    path_3.cubicTo(
        size.width * 0.8055000,
        size.height * 0.4200000,
        size.width * 0.8040000,
        size.height * 0.4220000,
        size.width * 0.8020000,
        size.height * 0.4250000);
    path_3.cubicTo(
        size.width * 0.8005000,
        size.height * 0.4280000,
        size.width * 0.7995000,
        size.height * 0.4320000,
        size.width * 0.7995000,
        size.height * 0.4370000);
    path_3.lineTo(size.width * 0.7995000, size.height * 0.8800000);
    path_3.cubicTo(
        size.width * 0.7995000,
        size.height * 0.8850000,
        size.width * 0.8005000,
        size.height * 0.8880000,
        size.width * 0.8020000,
        size.height * 0.8920000);
    path_3.cubicTo(
        size.width * 0.8035000,
        size.height * 0.8950000,
        size.width * 0.8055000,
        size.height * 0.8970000,
        size.width * 0.8080000,
        size.height * 0.8970000);
    path_3.lineTo(size.width * 0.9555000, size.height * 0.8970000);
    path_3.cubicTo(
        size.width * 0.9580000,
        size.height * 0.8970000,
        size.width * 0.9600000,
        size.height * 0.8950000,
        size.width * 0.9615000,
        size.height * 0.8920000);
    path_3.cubicTo(
        size.width * 0.9630000,
        size.height * 0.8890000,
        size.width * 0.9640000,
        size.height * 0.8850000,
        size.width * 0.9640000,
        size.height * 0.8800000);
    path_3.lineTo(size.width * 0.9640000, size.height * 0.8320000);
    path_3.cubicTo(
        size.width * 0.9640000,
        size.height * 0.8280000,
        size.width * 0.9635000,
        size.height * 0.8240000,
        size.width * 0.9620000,
        size.height * 0.8210000);
    path_3.close();

    Paint paint3Fill = Paint()..style = PaintingStyle.fill;
    paint3Fill.color = lettering;
    canvas.drawPath(path_3, paint3Fill);

    Paint paint4Fill = Paint()..style = PaintingStyle.fill;
    paint4Fill.color = lettering;
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset(size.width * 0.3555000, size.height * 0.6530000),
            width: size.width * 0.07700000,
            height: size.height * 0.1540000),
        paint4Fill);

    Path path_5 = Path();
    path_5.moveTo(size.width * 0.3555000, size.height * 0.3960000);
    path_5.cubicTo(
        size.width * 0.2845000,
        size.height * 0.3960000,
        size.width * 0.2270000,
        size.height * 0.5110000,
        size.width * 0.2270000,
        size.height * 0.6530000);
    path_5.cubicTo(
        size.width * 0.2270000,
        size.height * 0.7950000,
        size.width * 0.2850000,
        size.height * 0.9100000,
        size.width * 0.3555000,
        size.height * 0.9100000);
    path_5.cubicTo(
        size.width * 0.4260000,
        size.height * 0.9100000,
        size.width * 0.4840000,
        size.height * 0.7950000,
        size.width * 0.4840000,
        size.height * 0.6530000);
    path_5.cubicTo(
        size.width * 0.4840000,
        size.height * 0.5110000,
        size.width * 0.4265000,
        size.height * 0.3960000,
        size.width * 0.3555000,
        size.height * 0.3960000);
    path_5.close();
    path_5.moveTo(size.width * 0.3555000, size.height * 0.8280000);
    path_5.cubicTo(
        size.width * 0.3070000,
        size.height * 0.8280000,
        size.width * 0.2680000,
        size.height * 0.7500000,
        size.width * 0.2680000,
        size.height * 0.6530000);
    path_5.cubicTo(
        size.width * 0.2680000,
        size.height * 0.5560000,
        size.width * 0.3070000,
        size.height * 0.4780000,
        size.width * 0.3555000,
        size.height * 0.4780000);
    path_5.cubicTo(
        size.width * 0.4040000,
        size.height * 0.4780000,
        size.width * 0.4430000,
        size.height * 0.5560000,
        size.width * 0.4430000,
        size.height * 0.6530000);
    path_5.cubicTo(
        size.width * 0.4430000,
        size.height * 0.7500000,
        size.width * 0.4040000,
        size.height * 0.8280000,
        size.width * 0.3555000,
        size.height * 0.8280000);
    path_5.close();

    Paint paint5Fill = Paint()..style = PaintingStyle.fill;
    paint5Fill.color = lettering;
    canvas.drawPath(path_5, paint5Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
