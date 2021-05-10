import 'package:flutter/material.dart';

class User {
  String userid;
  String username;
  String idcard;
  String birthday;
  bool showGender;
  bool showPlace;

  User({
    @required this.userid,
    @required this.username,
    @required this.idcard,
    @required this.birthday,
    @required this.showGender,
    @required this.showPlace,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userid: json["userid"] as String,
      username: json["username"] as String,
      idcard: json["idcard"] as String,
      birthday: json["birthday"] as String,
      showGender: json["showGender"] as bool,
      showPlace: json["showPlace"] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "username": username,
        "idcard": idcard,
        "birthday": birthday,
        "showGender": showGender,
        "showPlace": showPlace
      };
}
