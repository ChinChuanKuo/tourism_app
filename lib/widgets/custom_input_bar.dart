import 'package:flutter/material.dart';
import 'package:tourism_app/config/config.dart';
import 'package:tourism_app/widgets/widgets.dart';

class CustomInputBar extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController textEditingController;
  final Function onPressed;
  final Function onChanged;
  final Function onSubmitted;

  const CustomInputBar({
    Key key,
    this.icon = Icons.search,
    @required this.hintText,
    @required this.textEditingController,
    @required this.onPressed,
    @required this.onChanged,
    @required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        border: new OutlineInputBorder(
          borderRadius: BorderRadius.all(const Radius.circular(30.0)),
          borderSide: BorderSide(style: BorderStyle.none),
        ),
        filled: true,
        fillColor: Colors.white,
        hoverColor: Colors.white,
        contentPadding: const EdgeInsets.only(left: 20.0, right: 12.0),
        hintText: hintText,
        suffixIcon: CircleButton(
          icon: icon,
          iconSize: 25.0,
          iconColor: Palette.defaultIconColor,
          onPressed: onPressed,
        ),
      ),
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
