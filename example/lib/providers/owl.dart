import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwlNotifier extends ChangeNotifier {
  OwlBottomNavState _owlBottomNavState = OwlBottomNavState.featured;

  OwlBottomNavState get owlBottomNavState => _owlBottomNavState;

  void setBottomNavState(OwlBottomNavState bottomNavState) {
    _owlBottomNavState = bottomNavState;
    notifyListeners();
  }
}

final owlProvider = ChangeNotifierProvider((ref) => OwlNotifier());

enum OwlBottomNavState { courses, featured, search }
