// To parse this JSON data, do
//
//     final getAllPlanResponceModel = getAllPlanResponceModelFromJson(jsonString);

import 'dart:convert';

GetAllPlanResponceModel getAllPlanResponceModelFromJson(String str) => GetAllPlanResponceModel.fromJson(json.decode(str));

String getAllPlanResponceModelToJson(GetAllPlanResponceModel data) => json.encode(data.toJson());

class GetAllPlanResponceModel {
  bool? success;
  String? message;
  List<Plan>? data;
  String? currentPage;
  int? page;

  GetAllPlanResponceModel({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.page,
  });

  factory GetAllPlanResponceModel.fromJson(Map<String, dynamic> json) => GetAllPlanResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Plan>.from(json["data"]!.map((x) => Plan.fromJson(x))),
    currentPage: json["currentPage"]==null?null:json["currentPage"].toString(),
    page: json["page"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "currentPage": currentPage,
    "page": page,
  };
}

class Plan {
  String? id;
  int? validity;
  String? planName;
  String? planDescription;
  int? amount;
  bool? productManagement;
  bool? serviceManagement;
  bool? detailedReport;
  bool? keywordReport;
  bool? competitorAnalysis;
  bool? addEvent;
  bool? replyWithAi;
  bool? disable;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Plan({
    this.id,
    this.validity,
    this.planName,
    this.planDescription,
    this.amount,
    this.productManagement,
    this.serviceManagement,
    this.detailedReport,
    this.keywordReport,
    this.competitorAnalysis,
    this.addEvent,
    this.replyWithAi,
    this.disable,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["_id"],
    validity: json["validity"],
    planName: json["planName"],
    planDescription: json["planDescription"],
    amount: json["amount"],
    productManagement: json["productManagement"],
    serviceManagement: json["serviceManagement"],
    detailedReport: json["detailedReport"],
    keywordReport: json["keywordReport"],
    competitorAnalysis: json["competitorAnalysis"],
    addEvent: json["addEvent"],
    replyWithAi: json["replyWithAI"],
    disable: json["disable"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "validity": validity,
    "planName": planName,
    "planDescription": planDescription,
    "amount": amount,
    "productManagement": productManagement,
    "serviceManagement": serviceManagement,
    "detailedReport": detailedReport,
    "keywordReport": keywordReport,
    "competitorAnalysis": competitorAnalysis,
    "addEvent": addEvent,
    "replyWithAI": replyWithAi,
    "disable": disable,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
