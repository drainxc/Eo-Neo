import 'package:flutter/material.dart';

class CountProvider extends ChangeNotifier {
  List<bool> _select = [false,false,false,false];

  List<bool> get select => _select;

  void changeState(n) {
    _select = List<bool>.filled(4, false, growable: true);
    _select[n] = true;
    notifyListeners();
  }
}