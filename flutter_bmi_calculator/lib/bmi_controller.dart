import 'package:flutter/material.dart';

class BmiController with ChangeNotifier {
  double _height = 160;
  double _weight = 60;

  double get height => _height;
  double get weight => _weight;

  void setHeight(double value) {
    _height = value;
    notifyListeners();
  }

  void setWeight(double value) {
    _weight = value;
    notifyListeners();
  }
}
