// To parse this JSON data, do
//
//     final defaultResponse = defaultResponseFromJson(jsonString);

import 'dart:convert';

DefaultResponse defaultResponseFromJson(String str) =>
    DefaultResponse.fromJson(json.decode(str));

String defaultResponseToJson(DefaultResponse data) =>
    json.encode(data.toJson());

class DefaultResponse {
  DefaultResponse({
    this.success,
    this.message,
  });

  bool? success;
  String? message;

  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      DefaultResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
