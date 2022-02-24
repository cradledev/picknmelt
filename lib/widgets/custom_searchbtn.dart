import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const SearchButton({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
        height: MediaQuery.of(context).size.height * 0.05,
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: Border.all(
              width: 5.0,
              color: const Color.fromRGBO(165, 102, 48, 1),
            )),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(165, 102, 48, 1),
                fontFamily: 'HandOfSean'),
          ),
        ),
      ),
    );
  }
}
