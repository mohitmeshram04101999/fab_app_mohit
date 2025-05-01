// To parse this JSON data, do
//
//     final notificationResponceModel = notificationResponceModelFromJson(jsonString);

import 'dart:convert';

NotificationResponceModel notificationResponceModelFromJson(String str) => NotificationResponceModel.fromJson(json.decode(str));

String notificationResponceModelToJson(NotificationResponceModel data) => json.encode(data.toJson());

class NotificationResponceModel {
  bool? success;
  String? message;
  List<NotificationDataModel>? data;

  NotificationResponceModel({
    this.success,
    this.message,
    this.data,
  });

  factory NotificationResponceModel.fromJson(Map<String, dynamic> json) => NotificationResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<NotificationDataModel>.from(json["data"]!.map((x) => NotificationDataModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NotificationDataModel {
  String? id;
  String? title;
  String? description;
  String? userId;
  bool? seen;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  NotificationDataModel({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.seen,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic> json) => NotificationDataModel(
    id: json["_id"],
    title: json["title"],
    description:  json["description"],
    userId:  json["userId"],
    seen: json["seen"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "userId": userId,
    "seen": seen,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}








