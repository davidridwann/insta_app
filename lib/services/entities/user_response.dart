// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators, prefer_if_null_operators

import 'dart:convert';

import 'package:insta_app/services/entities/login_response.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  UserResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  User? data;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}
