import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Color boxColor;
  final IconData icon;
  final double iconSize;
  final Color iconColor;
  final Function onPressed;

  const CircleButton({
    Key key,
    this.boxColor = Colors.transparent,
    @required this.icon,
    @required this.iconSize,
    this.iconColor = Colors.black,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        color: this.boxColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(this.icon),
        iconSize: this.iconSize,
        hoverColor: Colors.transparent,
        color: this.iconColor,
        onPressed: this.onPressed,
      ),
    );
  }
}
