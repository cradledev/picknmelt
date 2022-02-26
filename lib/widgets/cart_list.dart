import 'package:flutter/material.dart';

class CartList extends StatelessWidget {
  const CartList({Key key, this.cartData}) : super(key: key);
  final cartData;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cartData.length,
      shrinkWrap: false,
      physics: const ScrollPhysics(),
      itemBuilder: (context, index) {
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
                  "Inventory $index",
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
                  cartData[index]['name'].toString(),
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
                        onTap: () {},
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
                          onChanged: (text) {},
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Theme.of(context).primaryColor,
                            hintText: cartData[index]['name'].toString(),
                            // contentPadding: const EdgeInsets.only(
                            //     left: 10.0, bottom: 5.0, top: 5.0),
                            hintStyle: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w300,
                              fontFamily: "HandOfSean",
                              color: Colors.white,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
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
      },
    );
  }
}
