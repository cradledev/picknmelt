import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:picknmelt/store/data_notifier.dart';
import 'package:picknmelt/pages/scanner_page.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  "Total Stock",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    fontFamily: "OpenSans",
                    color: Color.fromRGBO(165, 102, 48, 1),
                  ),
                ),
              ),
              Consumer<DataNotifier>(
                builder: (context, cart, child) => Container(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    cart.totalPrice.toString(),
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300,
                      fontFamily: "OpenSans",
                      color: Color.fromRGBO(165, 102, 48, 1),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Image.asset(
                  "assets/images/search_footer_bg.png",
                  width: MediaQuery.of(context).size.width * 0.45,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 15, top: 0),
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.06,
                          margin: const EdgeInsets.only(left: 0, right: 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(
                                width: 5.0,
                                color: const Color.fromRGBO(165, 102, 48, 1),
                              )),
                          child: const Center(
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(165, 102, 48, 1),
                                  fontFamily: 'HandOfSean'),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ScannerPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: MediaQuery.of(context).size.height * 0.06,
                          margin: const EdgeInsets.only(left: 0, right: 0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              border: Border.all(
                                width: 5.0,
                                color: const Color.fromRGBO(165, 102, 48, 1),
                              )),
                          child: const Center(
                            child: Text(
                              "ReScan",
                              style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(165, 102, 48, 1),
                                  fontFamily: 'HandOfSean'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
