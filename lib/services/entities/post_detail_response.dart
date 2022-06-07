// To parse this JSON data, do
//
//     final postDetailResponse = postDetailResponseFromJson(jsonString);

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
    this.name,
    this.merk,
    this.specification,
    this.formula,
    this.stock,
    this.type,
    this.unit,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? merk;
  String? specification;
  String? formula;
  String? type;
  int? stock;
  String? unit;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '-',
        name: json["name"] ?? '-',
        merk: json["merk"] ?? '-',
        specification: json["specification"],
        formula: json["formula"] ?? '-',
        type: json["type"] ?? '-',
        stock: json["stock"] ?? '-',
        unit: json["unit"] ?? '-',
        status: json["status"] ?? '-',
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "merk": merk,
        "specification": specification,
        "formula": formula,
        "type": type,
        "stock": stock,
        "unit": unit,
        "status": status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
