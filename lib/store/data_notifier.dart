import 'package:flutter/foundation.dart';
import 'dart:typed_data';

class DataNotifier with ChangeNotifier {
  List _stocks = [];

  get stocks => _stocks;

  void updateStocks(List stocks) {
    _stocks = stocks;
    notifyListeners();
  }

  void updateStock(int _index, int _value) {
    _stocks[_index]['name'] = _value.toString();
    notifyListeners();
  }

  int get totalPrice =>
      _stocks.fold(0, (total, current) => total + int.parse(current['name']));
}
