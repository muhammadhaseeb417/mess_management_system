import 'package:flutter/material.dart';

class SignupProvider extends ChangeNotifier {
  bool checkBoxValue = false;

  void ChangeCheckBoxValue(value) {
    checkBoxValue = value;
    notifyListeners();
  }
}
