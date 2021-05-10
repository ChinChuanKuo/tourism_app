import 'package:flutter/material.dart';

class Status {
  final String license;
  final bool showWarn;
  final String status;

  Status({
    @required this.license,
    @required this.showWarn,
    @required this.status,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      license: json["license"] as String,
      showWarn: json["showWarn"] as bool,
      status: json["status"] as String,
    );
  }
}
