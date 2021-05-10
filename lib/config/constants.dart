import 'package:flutter/material.dart';

class Constants {
  static final labelStyle = TextStyle(
    color: Colors.black87,
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'OpenSans',
  );

  static final hintTextStyle = TextStyle(
    color: Colors.black54,
    fontFamily: 'OpenSans',
  );
}

class AgoUtils {
  static int getAge(DateTime afterdate, DateTime beforedate) {
    return afterdate.year - beforedate.year;
  }
}
