import 'package:flutter/material.dart';

class SerachFormField extends StatelessWidget {
  final String headingText;
  final String hintText;
  final bool obsecureText;
  final Widget suffixIcon;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final int maxLines;

  const SerachFormField(
      {Key key,
      this.headingText,
      this.hintText,
      this.obsecureText,
      this.suffixIcon,
      this.textInputType,
      this.textInputAction,
      this.controller,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 0, right: 0),
          // decoration: BoxDecoration(
          //   color: Theme.of(context).primaryColor,
          //   // borderRadius: BorderRadius.circular(15),
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 3.0),
            child: TextField(
              textAlignVertical: TextAlignVertical.center,
              maxLines: maxLines,
              controller: controller,
              textInputAction: textInputAction,
              keyboardType: textInputType,
              obscureText: obsecureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.deepOrange.shade100),
                suffixIcon: suffixIcon,
              ),
            ),
          ),
        )
      ],
    );
  }
}
