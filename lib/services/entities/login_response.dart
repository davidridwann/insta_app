// To parse this JSON data, do
//
//     final loginReponse = loginReponseFromJson(jsonString);

// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

LoginReponse loginReponseFromJson(String str) =>
    LoginReponse.fromJson(json.decode(str));

String loginReponseToJson(LoginReponse data) => json.encode(data.toJson());

class LoginReponse {
  LoginReponse({
    this.status,
    this.token,
    this.message,
    this.data,
  });

  bool? status;
  String? token;
  String? message;
  User? data;

  factory LoginReponse.fromJson(Map<String, dynamic> json) => LoginReponse(
        status: json["status"],
        token: json["token"],
        message: json['message'] == null ? null : json["message"],
        data: json["data"] == null ? null : User.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "token": token,
        "message": message,
        "data": data == null ? null : data?.toJson(),
      };
}

class User {
  User({
    this.id,
    this.name,
    this.username,
    this.image,
    this.pronouns,
    this.website,
    this.bio,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? username;
  String? image;
  String? pronouns;
  String? website;
  String? bio;
  String? email;
  String? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        image: json["image"],
        pronouns: json["pronouns"],
        website: json["website"],
        bio: json["bio"],
        email: json["email"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "image": image,
        "pronouns": pronouns,
        "website": website,
        "bio": bio,
        "email": email,
        "created_at": createdAt,
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
