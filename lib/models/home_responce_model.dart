// To parse this JSON data, do
//
//     final homeResponceModel = homeResponceModelFromJson(jsonString);

import 'dart:convert';

HomeResponceModel homeResponceModelFromJson(String str) => HomeResponceModel.fromJson(json.decode(str));

String homeResponceModelToJson(HomeResponceModel data) => json.encode(data.toJson());

class HomeResponceModel {
  bool? success;
  String? message;
  HomeData? data;

  HomeResponceModel({
    this.success,
    this.message,
    this.data,
  });

  factory HomeResponceModel.fromJson(Map<String, dynamic> json) => HomeResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : HomeData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class HomeData {
  int? auditScore;
  String? businessName;
  String? businessId;
  int? engagement;
  int? view;
  String? replyPending;
  int? moreKeywords;
  int? moreCompetitorAnalysis;
  List<Keyword>? keywords;
  ReviewMetrics? reviewMetrics;
  List<CompetitorAnalysis>? competitorAnalysis;
  List<Monthly>? monthly;
  List<Weekly>? weekly;

  HomeData({
    this.auditScore,
    this.businessName,
    this.businessId,
    this.engagement,
    this.view,
    this.replyPending,
    this.moreKeywords,
    this.moreCompetitorAnalysis,
    this.keywords,
    this.reviewMetrics,
    this.competitorAnalysis,
    this.monthly,
    this.weekly,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) => HomeData(
    auditScore: json["auditScore"],
    businessName: json["businessName"],
    businessId: json["businessId"],
    engagement: json["engagement"],
    view: json["view"],
    replyPending: json["replyPending"],
    moreKeywords: json["moreKeywords"],
    moreCompetitorAnalysis: json["moreCompetitorAnalysis"],
    keywords: json["keywords"] == null ? [] : List<Keyword>.from(json["keywords"]!.map((x) => Keyword.fromJson(x))),
    reviewMetrics: json["reviewMetrics"] == null ? null : ReviewMetrics.fromJson(json["reviewMetrics"]),
    competitorAnalysis: json["competitorAnalysis"] == null ? [] : List<CompetitorAnalysis>.from(json["competitorAnalysis"]!.map((x) => CompetitorAnalysis.fromJson(x))),
    monthly: json["Monthly"] == null ? [] : List<Monthly>.from(json["Monthly"]!.map((x) => Monthly.fromJson(x))),
    weekly: json["Weekly"] == null ? [] : List<Weekly>.from(json["Weekly"]!.map((x) => Weekly.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "auditScore": auditScore,
    "businessName": businessName,
    "businessId": businessId,
    "engagement": engagement,
    "view": view,
    "replyPending": replyPending,
    "moreKeywords": moreKeywords,
    "moreCompetitorAnalysis": moreCompetitorAnalysis,
    "keywords": keywords == null ? [] : List<dynamic>.from(keywords!.map((x) => x.toJson())),
    "reviewMetrics": reviewMetrics?.toJson(),
    "competitorAnalysis": competitorAnalysis == null ? [] : List<dynamic>.from(competitorAnalysis!.map((x) => x.toJson())),
    "Monthly": monthly == null ? [] : List<dynamic>.from(monthly!.map((x) => x.toJson())),
    "Weekly": weekly == null ? [] : List<dynamic>.from(weekly!.map((x) => x.toJson())),
  };
}

class CompetitorAnalysis {
  String? businessName;
  int? reviews;
  double? rating;
  int? photos;

  CompetitorAnalysis({
    this.businessName,
    this.reviews,
    this.rating,
    this.photos,
  });

  factory CompetitorAnalysis.fromJson(Map<String, dynamic> json) => CompetitorAnalysis(
    businessName: json["businessName"],
    reviews: json["reviews"],
    rating: json["rating"]?.toDouble(),
    photos: json["photos"],
  );

  Map<String, dynamic> toJson() => {
    "businessName": businessName,
    "reviews": reviews,
    "rating": rating,
    "photos": photos,
  };
}

class Keyword {
  String? name;
  int? count;

  Keyword({
    this.name,
    this.count,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
    name: json["name"],
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "count": count,
  };
}

class ReviewMetrics {
  int? activeDays;
  String? reviewResponded;
  int? googleReviews;

  ReviewMetrics({
    this.activeDays,
    this.reviewResponded,
    this.googleReviews,
  });

  factory ReviewMetrics.fromJson(Map<String, dynamic> json) => ReviewMetrics(
    activeDays: json["activeDays"],
    reviewResponded: json["reviewResponded"],
    googleReviews: json["googleReviews"],
  );

  Map<String, dynamic> toJson() => {
    "activeDays": activeDays,
    "reviewResponded": reviewResponded,
    "googleReviews": googleReviews,
  };
}




class Monthly {
  String? month;
  int? view;
  int? engagement;

  Monthly({
    this.month,
    this.view,
    this.engagement,
  });

  factory Monthly.fromJson(Map<String, dynamic> json) => Monthly(
    month: json["month"],
    view: json["view"],
    engagement: json["engagement"],
  );

  Map<String, dynamic> toJson() => {
    "month": month,
    "view": view,
    "engagement": engagement,
  };
}

class Weekly {
  String? day;
  int? view;
  int? engagement;

  Weekly({
    this.day,
    this.view,
    this.engagement,
  });

  factory Weekly.fromJson(Map<String, dynamic> json) => Weekly(
    day: json["day"],
    view: json["view"],
    engagement: json["engagement"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "view": view,
    "engagement": engagement,
  };
}
