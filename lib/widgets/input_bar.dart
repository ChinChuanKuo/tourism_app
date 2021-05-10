import 'package:flutter/material.dart';
import 'package:tourism_app/config/config.dart';

class CustomInputBar extends StatelessWidget {
  final String text;
  final IconData icon;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  final Function(String value) onChanged;

  const CustomInputBar({
    Key key,
    @required this.text,
    @required this.icon,
    this.hintText = "Enter your Info",
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    @required this.textEditingController,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: Text(text, style: Constants.labelStyle),
        ),
        SizedBox(height: 6.0),
        TextField(
          obscureText: obscureText,
          keyboardType: textInputType,
          style: TextStyle(fontFamily: 'OpenSans'),
          decoration: InputDecoration(
            border: new OutlineInputBorder(
              borderRadius: BorderRadius.all(const Radius.circular(24.0)),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            contentPadding: const EdgeInsets.only(left: 20.0, right: 12.0),
            prefixIcon: Icon(
              icon,
              color: Colors.black54,
            ),
            hintText: hintText,
            hintStyle: Constants.hintTextStyle,
          ),
          controller: textEditingController,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
