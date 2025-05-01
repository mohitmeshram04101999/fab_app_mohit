// To parse this JSON data, do
//
//     final googleReportDetaileModel = googleReportDetaileModelFromJson(jsonString);

import 'dart:convert';

GoogleReportDetaileModel googleReportDetaileModelFromJson(String str) => GoogleReportDetaileModel.fromJson(json.decode(str));

String googleReportDetaileModelToJson(GoogleReportDetaileModel data) => json.encode(data.toJson());

class GoogleReportDetaileModel {
  bool? success;
  String? message;
  List<GoogleReport>? data;
  String? totalScore;

  GoogleReportDetaileModel({
    this.success,
    this.message,
    this.data,
    this.totalScore,
  });

  factory GoogleReportDetaileModel.fromJson(Map<String, dynamic> json) => GoogleReportDetaileModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<GoogleReport>.from(json["data"]!.map((x) => GoogleReport.fromJson(x))),
    totalScore: json["totalScore"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalScore": totalScore,
  };
}

class GoogleReport {
  String? title;
  String? description;
  int? reviewScore;
  int? totalPoint;

  GoogleReport({
    this.title,
    this.description,
    this.reviewScore,
    this.totalPoint,
  });

  factory GoogleReport.fromJson(Map<String, dynamic> json) => GoogleReport(
    title: json["title"],
    description: json["description"],
    reviewScore: json["reviewScore"],
    totalPoint: json["totalPoint"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "reviewScore": reviewScore,
    "totalPoint": totalPoint,
  };
}
