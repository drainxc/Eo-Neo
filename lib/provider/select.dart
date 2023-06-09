import 'package:flutter/material.dart';

class SelectProvider extends ChangeNotifier {
  List<bool> _select = [true,false,false,false];

  List<bool> get select => _select;

  void changeState(n) {
    _select = List<bool>.filled(4, false, growable: true);
    _select[n] = true;
    notifyListeners();
  }
}