// To parse this JSON data, do
//
//     final moreKeyWordsResponceModel = moreKeyWordsResponceModelFromJson(jsonString);

import 'dart:convert';

MoreKeyWordsResponceModel moreKeyWordsResponceModelFromJson(String str) => MoreKeyWordsResponceModel.fromJson(json.decode(str));

String moreKeyWordsResponceModelToJson(MoreKeyWordsResponceModel data) => json.encode(data.toJson());

class MoreKeyWordsResponceModel {
  bool? success;
  String? message;
  List<MoreKeyword>? moreKeywords;

  MoreKeyWordsResponceModel({
    this.success,
    this.message,
    this.moreKeywords,
  });

  factory MoreKeyWordsResponceModel.fromJson(Map<String, dynamic> json) => MoreKeyWordsResponceModel(
    success: json["success"],
    message: json["message"],
    moreKeywords: json["moreKeywords"] == null ? [] : List<MoreKeyword>.from(json["moreKeywords"]!.map((x) => MoreKeyword.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "moreKeywords": moreKeywords == null ? [] : List<dynamic>.from(moreKeywords!.map((x) => x.toJson())),
  };
}

class MoreKeyword {
  String? name;
  int? count;

  MoreKeyword({
    this.name,
    this.count,
  });

  factory MoreKeyword.fromJson(Map<String, dynamic> json) => MoreKeyword(
    name: json["name"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "count": count,
  };
}
