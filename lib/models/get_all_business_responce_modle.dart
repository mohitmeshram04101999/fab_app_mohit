
// To parse this JSON data, do
//
//     final getAllBusinessResponceModel = getAllBusinessResponceModelFromJson(jsonString);

import 'dart:convert';

import 'package:fab_app/models/businessDetaiModel.dart';

GetAllBusinessResponceModel getAllBusinessResponceModelFromJson(String str) => GetAllBusinessResponceModel.fromJson(json.decode(str));

String getAllBusinessResponceModelToJson(GetAllBusinessResponceModel data) => json.encode(data.toJson());

class GetAllBusinessResponceModel {
  bool? success;
  String? message;
  List<BusinessModel>? data;

  GetAllBusinessResponceModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetAllBusinessResponceModel.fromJson(Map<String, dynamic> json) => GetAllBusinessResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<BusinessModel>.from(json["data"]!.map((x) => BusinessModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class BusinessModel {
  String? id;
  String? gmbLocationId;
  int? v;
  List<dynamic>? additionalCategory;
  String? address;
  List<dynamic>? aiReplySolution;
  DateTime? createdAt;
  String? description;
  bool? disable;
  String? gmbAccountId;
  String? gmbSyncStatus;
  String? name;
  String? primaryCategory;
  List<dynamic>? primaryKeywordForSeo;
  int? primaryPhone;
  List<dynamic>? products;
  List<RegularHour>? regularHours;
  DateTime? updatedAt;
  String? website;
  String? email;

  BusinessModel({
    this.id,
    this.gmbLocationId,
    this.v,
    this.additionalCategory,
    this.address,
    this.aiReplySolution,
    this.createdAt,
    this.description,
    this.disable,
    this.gmbAccountId,
    this.gmbSyncStatus,
    this.name,
    this.primaryCategory,
    this.primaryKeywordForSeo,
    this.primaryPhone,
    this.products,
    this.regularHours,
    this.updatedAt,
    this.website,
    this.email,
  });

  factory BusinessModel.fromJson(Map<String, dynamic> json) => BusinessModel(
    id: json["_id"],
    gmbLocationId: json["gmbLocationId"],
    v: json["__v"],
    additionalCategory: json["additionalCategory"] == null ? [] : List<dynamic>.from(json["additionalCategory"]!.map((x) => x)),
    address: json["address"],
    aiReplySolution: json["aiReplySolution"] == null ? [] : List<dynamic>.from(json["aiReplySolution"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    description: json["description"],
    disable: json["disable"],
    gmbAccountId: json["gmbAccountId"],
    gmbSyncStatus: json["gmbSyncStatus"],
    name: json["name"],
    primaryCategory: json["primaryCategory"],
    primaryKeywordForSeo: json["primaryKeywordForSEO"] == null ? [] : List<dynamic>.from(json["primaryKeywordForSEO"]!.map((x) => x)),
    primaryPhone: json["primaryPhone"],
    products: json["products"] == null ? [] : List<dynamic>.from(json["products"]!.map((x) => x)),
    regularHours: json["regularHours"] == null ? [] : List<RegularHour>.from(json["regularHours"]!.map((x) => RegularHour.fromJson(x))),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    website: json["website"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gmbLocationId": gmbLocationId,
    "__v": v,
    "additionalCategory": additionalCategory == null ? [] : List<dynamic>.from(additionalCategory!.map((x) => x)),
    "address": address,
    "aiReplySolution": aiReplySolution == null ? [] : List<dynamic>.from(aiReplySolution!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "disable": disable,
    "gmbAccountId": gmbAccountId,
    "gmbSyncStatus": gmbSyncStatus,
    "name": name,
    "primaryCategory": primaryCategory,
    "primaryKeywordForSEO": primaryKeywordForSeo == null ? [] : List<dynamic>.from(primaryKeywordForSeo!.map((x) => x)),
    "primaryPhone": primaryPhone,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x)),
    "regularHours": regularHours == null ? [] : List<dynamic>.from(regularHours!.map((x) => x.toJson())),
    "updatedAt": updatedAt?.toIso8601String(),
    "website": website,
    "email": email,
  };
}

