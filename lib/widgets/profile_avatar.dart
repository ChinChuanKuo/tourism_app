import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;

  const ProfileAvatar({
    Key key,
    @required this.imageUrl,
    this.radius = 26.5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: radius,
          backgroundImage: imageUrl == null ? null : AssetImage(imageUrl),
        ),
      ],
    );
  }
}
