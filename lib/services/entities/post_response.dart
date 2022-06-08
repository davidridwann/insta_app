// To parse this JSON data, do
//
//     final postResponse = postResponseFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators, non_constant_identifier_names

import 'dart:convert';

PostResponse postResponseFromJson(String str) =>
    PostResponse.fromJson(json.decode(str));

String itemResponseToJson(PostResponse data) => json.encode(data.toJson());

class PostResponse {
  PostResponse({
    this.success,
    this.message,
    this.data,
  });

  bool? success;
  String? message;
  Data? data;

  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
        success: json["success"] ?? null,
        message: json["message"] ?? null,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success ?? null,
        "message": message ?? null,
        "data": data == null ? null : data!.toJson(),
      };
}

class Data {
  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Post>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentPage: json["current_page"] ?? null,
        data: json["data"] == null
            ? null
            : List<Post>.from(json["data"].map((x) => Post.fromJson(x))),
        firstPageUrl: json["first_page_url"] ?? null,
        from: json["from"] ?? null,
        lastPage: json["last_page"] ?? null,
        lastPageUrl: json["last_page_url"] ?? null,
        nextPageUrl: json["next_page_url"],
        path: json["path"] ?? null,
        perPage: json["per_page"] ?? null,
        prevPageUrl: json["prev_page_url"],
        to: json["to"] ?? null,
        total: json["total"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage ?? null,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl ?? null,
        "from": from ?? null,
        "last_page": lastPage ?? null,
        "last_page_url": lastPageUrl ?? null,
        "next_page_url": nextPageUrl,
        "path": path ?? null,
        "per_page": perPage ?? null,
        "prev_page_url": prevPageUrl,
        "to": to ?? null,
        "total": total ?? null,
      };
}

class Post {
  Post({
    this.id,
    this.post,
    this.caption,
    this.created_by,
    this.total_like,
    this.hide_comment,
    this.hide_like,
    this.is_archive,
    this.is_edit,
    this.is_like,
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
  bool? is_like;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"] ?? '-',
        post: json["post"] ?? null,
        caption: json["caption"] ?? null,
        created_by: json["created_by"] ?? null,
        total_like: json["total_like"] ?? null,
        hide_comment: json["hide_comment"] ?? null,
        hide_like: json["hide_like"] ?? null,
        is_archive: json["is_archive"] ?? null,
        is_edit: json["is_edit"] ?? null,
        is_like: json["is_like"] ?? null,
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
        "total_like": total_like ?? null,
        "created_by": created_by ?? null,
        "hide_comment": hide_comment ?? null,
        "hide_like": hide_like ?? null,
        "is_archive": is_archive ?? null,
        "is_edit": is_edit ?? null,
        "is_like": is_like ?? null,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
