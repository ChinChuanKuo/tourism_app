import 'package:flutter/material.dart';
import 'package:tourism_app/models/models.dart';
import 'package:tourism_app/widgets/widgets.dart';

class PhotoSelector extends StatefulWidget {
  final Category category;

  const PhotoSelector({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _PhotoSelectorState createState() => _PhotoSelectorState();
}

class _PhotoSelectorState extends State<PhotoSelector> {
  void onPressedCancel() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    final bool isTablet = Responsive.isTablet(context),
        isDesktop = Responsive.isDesktop(context);
    return Column(
      children: [
        SheetTile(
          title: widget.category.title,
          onPressedCancel: onPressedCancel,
        ),
        Expanded(
          child: Padding(
            padding: isDesktop
                ? const EdgeInsets.all(8.0)
                : const EdgeInsets.all(0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Image(
                image: AssetImage(widget.category.imageUrl),
                height: double.infinity,
                width: double.infinity,
                fit: isTablet ? BoxFit.fitHeight : BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
