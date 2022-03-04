import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'dart:typed_data';
import 'package:picknmelt/model/stock_item_model.dart';

class DataNotifier with ChangeNotifier {
  List<StockItemModel> _stocks = [];

  get stocks => _stocks;

  void updateStocks(stocks) {
    _stocks = stocks;
    notifyListeners();
  }

  void updateStock(int _index, int _value) {
    for (StockItemModel _temp in stocks) {
      if (_temp.inventoryId == _index) {
        // print(jsonEncode(_temp));
        _temp.inventoryStock = _value;
      }
    }
    notifyListeners();
  }

  int get totalPrice =>
      _stocks.fold(0, (total, current) => total + current.inventoryStock);
}
