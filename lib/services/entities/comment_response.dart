// To parse this JSON data, do
//
//     final commentResponse = commentResponseFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators, non_constant_identifier_names

import 'dart:convert';

CommentResponse commentResponseFromJson(String str) =>
    CommentResponse.fromJson(json.decode(str));

String itemResponseToJson(CommentResponse data) => json.encode(data.toJson());

class CommentResponse {
  CommentResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  List<Comment>? data;

  factory CommentResponse.fromJson(Map<String, dynamic> json) =>
      CommentResponse(
        success: json["success"] ?? null,
        message: json["message"] ?? null,
        data: json["data"] == null
            ? null
            : List<Comment>.from(json["data"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success ?? null,
        "message": message ?? null,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Comment {
  Comment(
      {this.id,
      this.user_id,
      this.post_id,
      this.comment_id,
      this.comment,
      this.created_by,
      this.data,
      this.createdAt,
      this.updatedAt});

  int? id;
  int? user_id;
  int? post_id;
  int? comment_id;
  String? comment;
  String? created_by;
  List<CommentChild>? data;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"] ?? '-',
        user_id: json["user_id"] ?? null,
        post_id: json["post_id"] ?? null,
        comment_id: json["comment_id"] ?? null,
        comment: json["comment"] ?? null,
        created_by: json["created_by"] ?? null,
        data: json["data"] == null
            ? null
            : List<CommentChild>.from(
                json["data"].map((x) => CommentChild.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "user_id": user_id ?? null,
        "post_id": post_id ?? null,
        "comment_id": comment_id ?? null,
        "comment": comment ?? null,
        "created_by": created_by ?? null,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class CommentChild {
  CommentChild(
      {this.id,
      this.user_id,
      this.post_id,
      this.comment_id,
      this.comment,
      this.created_by,
      this.createdAt,
      this.updatedAt});

  int? id;
  int? user_id;
  int? post_id;
  int? comment_id;
  String? comment;
  String? created_by;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CommentChild.fromJson(Map<String, dynamic> json) => CommentChild(
        id: json["id"] ?? '-',
        user_id: json["user_id"] ?? null,
        post_id: json["post_id"] ?? null,
        comment_id: json["comment_id"] ?? null,
        comment: json["comment"] ?? null,
        created_by: json["created_by"] ?? null,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "user_id": user_id ?? null,
        "post_id": post_id ?? null,
        "comment_id": comment_id ?? null,
        "comment": comment ?? null,
        "created_by": created_by ?? null,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
