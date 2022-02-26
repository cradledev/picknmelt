import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onTap;

  const AuthButton({Key key, this.onTap, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(165, 102, 48, 1),
                fontFamily: 'HandOfSean'),
          ),
        ),
      ),
    );
  }
}
