class StockItemModel {
  int inventoryId;
  String inventoryName;
  int inventoryStock;
  StockItemModel({this.inventoryId, this.inventoryName, this.inventoryStock});
  factory StockItemModel.fromJson(Map<String, dynamic> json) {
    return StockItemModel(
        inventoryId: json['inventory_id'] as int,
        inventoryName: json['inventory_name'] as String,
        inventoryStock: json['inventory_stock'] as int);
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['inventoryId'] = inventoryId;
    map['inventoryName'] = inventoryName;
    map['inventoryStock'] = inventoryStock;
    return map;
  }
}

class StockModel {
  StockItemModel inventoryModel;
  StockModel({this.inventoryModel});
  factory StockModel.fromJson(dynamic json) {
    return StockModel(
      inventoryModel: json as StockItemModel,
    );
  }
  // Map<String, dynamic> toJson() {
  //   final map = <String, dynamic>{};
  //   map['inventory_id'] = inventoryModel;
  //   return map;
  // }
}
