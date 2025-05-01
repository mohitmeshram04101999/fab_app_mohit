
// To parse this JSON data, do
//
//     final getAllReviewResponce = getAllReviewResponceFromJson(jsonString);

import 'dart:convert';

GetAllReviewResponce getAllReviewResponceFromJson(String str) => GetAllReviewResponce.fromJson(json.decode(str));

String getAllReviewResponceToJson(GetAllReviewResponce data) => json.encode(data.toJson());

class GetAllReviewResponce {
  bool? success;
  String? message;
  ReviewData? data;
  AverageRating? averageRating;

  GetAllReviewResponce({
    this.success,
    this.message,
    this.data,
    this.averageRating
  });

  factory GetAllReviewResponce.fromJson(Map<String, dynamic> json) => GetAllReviewResponce(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ReviewData.fromJson(json["data"]),
    averageRating: json["averageRating"] == null ? null : AverageRating.fromJson(json["averageRating"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    'averageRating':averageRating?.toJson()
  };
}

class ReviewData {
  String? id;
  String? gmbLocationId;
  int? v;
  String? businessId;
  DateTime? createdAt;
  List<Review>? reviews;
  DateTime? updatedAt;

  ReviewData({
    this.id,
    this.gmbLocationId,
    this.v,
    this.businessId,
    this.createdAt,
    this.reviews,
    this.updatedAt,
  });

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
    id: json["_id"],
    gmbLocationId: json["gmbLocationId"],
    v: json["__v"],
    businessId: json["businessId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    reviews: json["reviews"] == null ? [] : List<Review>.from(json["reviews"]!.map((x) => Review.fromJson(x))),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gmbLocationId": gmbLocationId,
    "__v": v,
    "businessId": businessId,
    "createdAt": createdAt?.toIso8601String(),
    "reviews": reviews == null ? [] : List<dynamic>.from(reviews!.map((x) => x.toJson())),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Review {
  String? reviewId;
  String? reviewImg;
  String? reviewerName;
  double? rating;
  String? comment;
  DateTime? reviewTime;
  String? response;
  bool? isRead;
  String? id;

  Review({
    this.reviewImg,
    this.reviewId,
    this.reviewerName,
    this.rating,
    this.comment,
    this.reviewTime,
    this.response,
    this.isRead,
    this.id,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    reviewId: json["reviewId"],
    reviewImg: json["reviewImg"],
    reviewerName: json["reviewerName"],
    rating: json["rating"]!=null?double.parse(json["rating"].toString()):null,
    comment: json["comment"],
    reviewTime: json["reviewTime"] == null ? null : DateTime.parse(json["reviewTime"]),
    response: json["response"],
    isRead: json["isRead"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "reviewId": reviewId,
    "reviewImg": reviewImg,
    "reviewerName": reviewerName,
    "rating": rating,
    "comment": comment,
    "reviewTime": reviewTime?.toIso8601String(),
    "response": response,
    "isRead": isRead,
    "_id": id,
  };
}


class AverageRating {
  String? title;
  String? description;
  double? averageRating;
  int? minimumRating;
  int? maxRating;

  AverageRating({
    this.title,
    this.description,
    this.averageRating,
    this.minimumRating,
    this.maxRating,
  });

  factory AverageRating.fromJson(Map<String, dynamic> json) => AverageRating(
    title: json["title"],
    description: json["description"],
    averageRating: json["averageRating"]?.toDouble(),
    minimumRating: json["minimumRating"],
    maxRating: json["maxRating"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "averageRating": averageRating,
    "minimumRating": minimumRating,
    "maxRating": maxRating,
  };
}
