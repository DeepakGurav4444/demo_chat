import 'package:flutter/material.dart';

class TextFieldProvider extends ChangeNotifier {
  bool makePasswordVissible = false;
  set setVissiblePass(bool val) {
    makePasswordVissible = val;
    notifyListeners();
  }

  bool get getVissiblePassword => makePasswordVissible;
}