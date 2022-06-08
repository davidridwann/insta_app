// To parse this JSON data, do
//
//     final postDetailResponse = postDetailResponseFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators, non_constant_identifier_names

import 'dart:convert';

PostDetailResponse postDetailResponseFromJson(String str) =>
    PostDetailResponse.fromJson(json.decode(str));

String itemDetailResponseToJson(PostDetailResponse data) =>
    json.encode(data.toJson());

class PostDetailResponse {
  PostDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory PostDetailResponse.fromJson(Map<String, dynamic> json) =>
      PostDetailResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.post,
    this.caption,
    this.created_by,
    this.total_like,
    this.hide_comment,
    this.hide_like,
    this.is_archive,
    this.is_edit,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? post;
  String? caption;
  String? created_by;
  int? total_like;
  bool? hide_comment;
  bool? hide_like;
  bool? is_archive;
  bool? is_edit;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '-',
        post: json["post"] ?? null,
        caption: json["caption"] ?? null,
        created_by: json["created_by"] ?? null,
        total_like: json["total_like"] ?? null,
        hide_comment: json["hide_comment"] ?? null,
        hide_like: json["hide_like"] ?? null,
        is_archive: json["is_archive"] ?? null,
        is_edit: json["is_edit"] ?? null,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "post": post ?? null,
        "caption": caption ?? null,
        "created_by": created_by ?? null,
        "total_like": total_like ?? null,
        "hide_comment": hide_comment ?? null,
        "hide_like": hide_like ?? null,
        "is_archive": is_archive ?? null,
        "is_edit": is_edit ?? null,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
