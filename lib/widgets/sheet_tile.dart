import 'package:flutter/material.dart';
import 'package:tourism_app/config/config.dart';
import 'package:tourism_app/widgets/widgets.dart';

class SheetTile extends StatelessWidget {
  final String title;
  final Function onPressedCancel;

  const SheetTile({
    Key key,
    @required this.title,
    @required this.onPressedCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => !Responsive.isDesktop(context)
      ? MobileTile(title: title, onPressedCancel: onPressedCancel)
      : DesktopTile(title: title, onPressedCancel: onPressedCancel);
}

class MobileTile extends StatelessWidget {
  final String title;
  final Function onPressedCancel;

  const MobileTile({
    Key key,
    @required this.title,
    @required this.onPressedCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Responsive.isTablet(context);
    return Padding(
      padding: isTablet
          ? const EdgeInsets.only(
              right: 15.0, left: 15.0, top: 10.0, bottom: 3.0)
          : const EdgeInsets.only(right: 15.0, left: 15.0, top: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ),
          CircleButton(
            boxColor: Colors.grey[200],
            icon: Icons.close,
            iconSize: 25.0,
            iconColor: Palette.defaultIconColor,
            onPressed: onPressedCancel,
          ),
        ],
      ),
    );
  }
}

class DesktopTile extends StatelessWidget {
  final String title;
  final Function onPressedCancel;

  const DesktopTile({
    Key key,
    @required this.title,
    @required this.onPressedCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 14.0, left: 15.0, top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            CircleButton(
              boxColor: Colors.grey[200],
              icon: Icons.close,
              iconSize: 21.0,
              iconColor: Palette.defaultIconColor,
              onPressed: onPressedCancel,
            ),
          ],
        ),
      );
}
