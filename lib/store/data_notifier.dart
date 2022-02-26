import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class DataNotifier with ChangeNotifier {
  List _stocks = [];

  get stocks => _stocks;

  void updateStocks(List stocks) {
    _stocks = stocks;
    notifyListeners();
  }

  int get totalPrice =>
      stocks.fold(0, (total, current) => total + current.amount);
}
