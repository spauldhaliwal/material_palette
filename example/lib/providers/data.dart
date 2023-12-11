import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const minY = 1;
const maxYBar = 5;
const maxYSpark = 10;

class DataNotifier extends ChangeNotifier {
  static final rnd = Random();

  updateData() {
    Future.delayed(const Duration(milliseconds: 10), () {
      _chartData = [
        for (int item = 0; item <= 6; item++) _rndChartVal(),
      ];
      _sparkData = [
        for (int item = 0; item <= 21; item++) _rndSparkVal(),
      ];

      _conversionNo = rnd.nextDouble() * 1000;
      _conversionPercentage = 1 + rnd.nextInt(1000 - 1);

      _reachNo = 1 + rnd.nextDouble() * 1000;
      _reachPercentage = (rnd.nextDouble() * 10).toDouble();

      notifyListeners();
    });
  }

  double _rndChartVal() {
    var r = minY + rnd.nextInt(maxYBar - minY);
    return r.toDouble();
  }

  double _rndSparkVal() {
    var r = minY + rnd.nextInt(maxYSpark - minY);
    return r.toDouble();
  }

  List<double> _chartData = [
    for (int item = 0; item <= 7; item++)
      1 + Random().nextInt(5 - 1).toDouble(),
  ];
  List<double> get chartData => _chartData;

  List<double> _sparkData = [
    for (int item = 0; item <= 21; item++)
      1 + Random().nextInt(10 - 1).toDouble(),
  ];
  List<double> get sparkData => _sparkData;

  double _conversionNo = 537;
  double get conversionNo => _conversionNo;

  int _conversionPercentage = 22;
  int get conversionPercentage => _conversionPercentage;

  double _reachNo = 432.1;
  double get reachNo => _reachNo;

  double _reachPercentage = 22;
  double get reachPercentage => _reachPercentage;
}

final dataProvider = ChangeNotifierProvider((ref) => DataNotifier());
