import 'dart:convert';

import 'package:flutter/material.dart';

class Group {
  String category;
  bool traffic;
  bool location;
  List<dynamic> items;
  bool showWarn;

  Group({
    @required this.category,
    @required this.traffic,
    @required this.location,
    @required this.items,
    @required this.showWarn,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      category: json["category"] as String,
      traffic: json["traffic"] as bool,
      location: json["location"] as bool,
      items: json["items"],
      showWarn: json["showWarn"] as bool,
    );
  }
}
