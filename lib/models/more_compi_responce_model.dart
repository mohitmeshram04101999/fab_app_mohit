// To parse this JSON data, do
//
//     final moreCompWordsResponceModel = moreCompWordsResponceModelFromJson(jsonString);

import 'dart:convert';

import 'package:fab_app/models/home_responce_model.dart';

MoreCompWordsResponceModel moreCompWordsResponceModelFromJson(String str) => MoreCompWordsResponceModel.fromJson(json.decode(str));

String moreCompWordsResponceModelToJson(MoreCompWordsResponceModel data) => json.encode(data.toJson());

class MoreCompWordsResponceModel {
  bool? success;
  String? message;
  List<CompetitorAnalysis>? data;

  MoreCompWordsResponceModel({
    this.success,
    this.message,
    this.data,
  });

  factory MoreCompWordsResponceModel.fromJson(Map<String, dynamic> json) => MoreCompWordsResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<CompetitorAnalysis>.from(json["data"]!.map((x) => CompetitorAnalysis.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

