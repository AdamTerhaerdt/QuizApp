import 'package:flutter/material.dart';

class AboutState with ChangeNotifier {
  List<bool> _expandedStates = [true, false, false];

  bool isExpanded(int index) {
    if (index >= 0 || index < _expandedStates.length) {
      return _expandedStates[index];
    }
    return false;
  }

  void toggleExpansion(int index) {
    _expandedStates[index] = !_expandedStates[index];
    notifyListeners();
  }
}
