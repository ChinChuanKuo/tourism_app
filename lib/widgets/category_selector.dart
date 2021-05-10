import 'package:flutter/material.dart';
import 'package:tourism_app/config/config.dart';
import 'package:tourism_app/models/models.dart';

class CategorySelector extends StatelessWidget {
  final String categoryId;
  final Function(String id) onTapGesture;
  final Category category;
  final Function(Category category) onTapPhoto;

  const CategorySelector({
    Key key,
    @required this.categoryId,
    @required this.onTapGesture,
    @required this.category,
    @required this.onTapPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapGesture(category.id),
      child: Card(
        margin: const EdgeInsets.only(right: 15.0),
        elevation: 14.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        shadowColor: Palette.boardColor,
        child: Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: categoryId == category.id
                ? Palette.selectedIconColor
                : Palette.defaultIconColor,
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.0),
                  child: Image(
                    image: AssetImage(category.imageUrl),
                    height: double.infinity,
                    width: 220.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {onTapGesture(category.id), onTapPhoto(category)},
                child: Text(
                  category.title,
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
