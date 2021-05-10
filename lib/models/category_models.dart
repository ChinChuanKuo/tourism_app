import 'package:flutter/material.dart';

class Category {
  String id;
  String title;
  String imageUrl;

  Category({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"] as String,
      title: json["title"] as String,
      imageUrl: json["imageUrl"] as String,
    );
  }
}
