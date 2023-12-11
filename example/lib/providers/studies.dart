import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyNotifier extends ChangeNotifier {
  CaseStudy _caseStudy = CaseStudy.analytics;

  CaseStudy get caseStudy => _caseStudy;

  String _activeApp = 'analytics';
  String get activeApp => _activeApp;

  void setActiveApp(String caseStudy) {
    _activeApp = caseStudy;
    notifyListeners();
  }

  void setCaseStudy(CaseStudy caseStudy) {
    _caseStudy = caseStudy;
    notifyListeners();
  }
}

final caseStudyProvider = ChangeNotifierProvider((ref) => StudyNotifier());

enum CaseStudy {
  analytics,
  green,
}
