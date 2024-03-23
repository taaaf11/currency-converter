import 'package:flutter/material.dart';

class FromCurrencyProvider with ChangeNotifier {
  String _current = '';

  void change(String newCurrency) {
    _current = newCurrency;
    notifyListeners();
  }

  String get current => _current;
}

class ToCurrencyProvider with ChangeNotifier {
  String _current = '';

  void change(String newCurrency) {
    _current = newCurrency;
    notifyListeners();
  }

  String get current => _current;
}
