import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:picknmelt/store/data_notifier.dart';
import 'package:provider/provider.dart';
import 'package:picknmelt/model/stock_item_model.dart';
import 'package:picknmelt/store/index.dart';

class StockItem extends StatefulWidget {
  final StockItemModel data;
  const StockItem({Key key, this.data}) : super(key: key);
  @override
  _StockItem createState() => _StockItem();
}

class _StockItem extends State<StockItem> {
  AppState state;
  TextEditingController _itemAmountController;

  @override
  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);
    _itemAmountController = TextEditingController();
    _itemAmountController.text = widget.data.inventoryStock.toString();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.3,
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              widget.data.inventoryName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(165, 102, 48, 1),
                  fontFamily: 'HandOfSean'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.2,
            padding: EdgeInsets.zero,
            child: Text(
              widget.data.inventoryStock.toString(),
              style: const TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.w300,
                fontFamily: "OpenSans",
                color: Color.fromRGBO(165, 102, 48, 1),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      String _stockAmount = _itemAmountController.text;
                      if (_stockAmount.trim().isNotEmpty) {
                        int _temp = int.parse(_stockAmount);

                        _temp = _temp - 1;
                        if (_temp <= 0) _temp = 0;
                        _itemAmountController.text = _temp.toString();
                        Provider.of<DataNotifier>(context, listen: false)
                            .updateStock(widget.data.inventoryId, _temp);
                        // state.notifyToastDanger(
                        //     context: context, message: _temp.toString());
                      }
                    },
                    child: Icon(
                      Icons.remove_circle_sharp,
                      size: 30.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.center,
                      maxLines: 1,
                      obscureText: false,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      controller: _itemAmountController,
                      onChanged: (text) {
                        int _stockAmount = 0;
                        if (text.isEmpty) {
                          _itemAmountController.text = "0";
                        } else {
                          _stockAmount = int.parse(text);
                        }
                        Provider.of<DataNotifier>(context, listen: false)
                            .updateStock(widget.data.inventoryId, _stockAmount);
                        // state.notifyToastDanger(
                        //     context: context, message: _stockAmount.toString());
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).primaryColor,
                        hintText: widget.data.inventoryStock.toString(),
                        // contentPadding: const EdgeInsets.only(
                        //     left: 10.0, bottom: 5.0, top: 5.0),
                        hintStyle: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                          fontFamily: "HandOfSean",
                          color: Colors.white,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      String _stockAmount = _itemAmountController.text;
                      if (_stockAmount.trim().isNotEmpty) {
                        int _temp = int.parse(_stockAmount);
                        _temp = _temp + 1;
                        if (_temp < 1) _temp = 1;
                        _itemAmountController.text = _temp.toString();
                        Provider.of<DataNotifier>(context, listen: false)
                            .updateStock(widget.data.inventoryId, _temp);
                        // state.notifyToastDanger(
                        //     context: context, message: _temp.toString());
                      } else {
                        int _temp = 0;
                        _temp = _temp + 1;
                        _itemAmountController.text = _temp.toString();
                        Provider.of<DataNotifier>(context, listen: false)
                            .updateStock(widget.data.inventoryId, _temp);
                        // state.notifyToastDanger(
                        //     context: context, message: _temp.toString());
                      }
                    },
                    child: Icon(
                      Icons.add_circle_sharp,
                      color: Theme.of(context).primaryColor,
                      size: 30.0,
                    ),
                  ),
                  // IconButton(
                  //   padding: EdgeInsets.zero,
                  //   color: const Color.fromRGBO(255, 126, 0, 1.0),
                  //   icon: const Icon(Icons.add_circle_sharp),
                  //   onPressed: () {},
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
