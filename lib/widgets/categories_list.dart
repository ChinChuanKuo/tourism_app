import 'package:flutter/material.dart';
import 'package:tourism_app/config/config.dart';
import 'package:tourism_app/data/data.dart';
import 'package:tourism_app/models/models.dart';
import 'package:tourism_app/widgets/widgets.dart';

class CategoriesList extends StatelessWidget {
  final String categoryId;
  final Function(String id) onTapGesture;
  final Function(Category category) onTapPhoto;

  const CategoriesList({
    Key key,
    @required this.categoryId,
    @required this.onTapGesture,
    @required this.onTapPhoto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 320.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              //padding: const EdgeInsets.symmetric(horizontal: 6.0),
              scrollDirection: Axis.vertical,
              itemCount: categories(context).length,
              itemBuilder: (BuildContext context, int index) {
                final Category category = categories(context)[index];
                final categoryIndex = categoryId == category.id;
                return WidgetAnimator(
                  vertical: true,
                  child: Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    padding: const EdgeInsets.all(3.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(24.0),
                      onTap: () => onTapGesture(category.id),
                      child: Row(
                        children: [
                          ProfileAvatar(imageUrl: category.imageUrl),
                          SizedBox(width: 12.0),
                          Flexible(
                            child: GestureDetector(
                              onTap: () => {
                                onTapGesture(category.id),
                                onTapPhoto(category)
                              },
                              child: Text(
                                category.title,
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: categoryIndex
                                      ? Palette.selectedIconColor
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
