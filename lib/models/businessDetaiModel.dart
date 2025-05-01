// To parse this JSON data, do
//
//     final businessDetailResponceModel = businessDetailResponceModelFromJson(jsonString);

import 'dart:convert';

BusinessDetailResponceModel businessDetailResponceModelFromJson(String str) => BusinessDetailResponceModel.fromJson(json.decode(str));

String businessDetailResponceModelToJson(BusinessDetailResponceModel data) => json.encode(data.toJson());

class BusinessDetailResponceModel {
  bool? success;
  String? message;
  BusinessDetail? data;

  BusinessDetailResponceModel({
    this.success,
    this.message,
    this.data,
  });

  factory BusinessDetailResponceModel.fromJson(Map<String, dynamic> json) => BusinessDetailResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : BusinessDetail.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class BusinessDetail {
  String? id;
  String? gmbLocationId;
  int? v;
  List<AdditionalCategory>? additionalCategory;
  String? address;
  List<dynamic>? aiReplySolution;
  DateTime? createdAt;
  String? description;
  bool? disable;
  String? gmbAccountId;
  String? gmbSyncStatus;
  String? name;
  String? primaryCategory;
  List<KeyWordForSeo>? primaryKeywordForSeo;
  int? primaryPhone;
  List<Product>? products;
  List<RegularHour>? regularHours;
  DateTime? updatedAt;
  String? website;
  List<Post>? post;
  List<Media>? media;
  String? img;
  List<BusinessService>? services;
  DateTime? openingDate;
  String? email;

  BusinessDetail({
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
    this.post,
    this.media,
    this.img,
    this.services,
    this.openingDate,
    this.email
  });

  factory BusinessDetail.fromJson(Map<String, dynamic> json) => BusinessDetail(
    id: json["_id"],
    gmbLocationId: json["gmbLocationId"],
    v: json["__v"],
    additionalCategory: json["additionalCategory"] == null ? [] : List<AdditionalCategory>.from(json["additionalCategory"]!.map((x) => AdditionalCategory.fromJson(x))),
    address: json["address"],
    aiReplySolution: json["aiReplySolution"] == null ? [] : List<dynamic>.from(json["aiReplySolution"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    description: json["description"],
    disable: json["disable"],
    gmbAccountId: json["gmbAccountId"],
    gmbSyncStatus: json["gmbSyncStatus"],
    name: json["name"],
    primaryCategory: json["primaryCategory"],
    primaryKeywordForSeo: json["primaryKeywordForSEO"] == null ? [] : List<KeyWordForSeo>.from(json["primaryKeywordForSEO"]!.map((x) => KeyWordForSeo.fromJson(x))),
    primaryPhone: json["primaryPhone"],
    products: json["products"] == null ? [] : List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    regularHours: json["regularHours"] == null ? [] : List<RegularHour>.from(json["regularHours"]!.map((x) => RegularHour.fromJson(x))),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    website: json["website"],
    post: json["post"] == null ? [] : List<Post>.from(json["post"]!.map((x) => Post.fromJson(x))),
    media: json["media"] == null ? [] : List<Media>.from(json["media"]!.map((x) => Media.fromJson(x))),
    img: json["img"],
    email: json["email"],
    openingDate:DateTime.parse( json["openingDate"]??''),
    services: json["services"] == null ? [] : List<BusinessService>.from(json["services"]!.map((x) => BusinessService.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gmbLocationId": gmbLocationId,
    "__v": v,
    "additionalCategory": additionalCategory == null ? [] : List<dynamic>.from(additionalCategory!.map((x) =>  x.toJson())),
    "address": address,
    "aiReplySolution": aiReplySolution == null ? [] : List<dynamic>.from(aiReplySolution!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "disable": disable,
    "gmbAccountId": gmbAccountId,
    "gmbSyncStatus": gmbSyncStatus,
    "name": name,
    "primaryCategory": primaryCategory,
    "primaryKeywordForSEO": primaryKeywordForSeo == null ? [] : List<dynamic>.from(primaryKeywordForSeo!.map((x) => x.toJson())),
    "primaryPhone": primaryPhone,
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "regularHours": regularHours == null ? [] : List<dynamic>.from(regularHours!.map((x) => x.toJson())),
    "updatedAt": updatedAt?.toIso8601String(),
    "website": website,
    "post": post == null ? [] : List<dynamic>.from(post!.map((x) => x.toJson())),
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
    "img": img,
    "services": services == null ? [] : List<dynamic>.from(services!.map((x) => x.toJson())),
    'openingDate':openingDate,
    'email':email
  };
}

class Media {
  String? id;
  String? gmbMediaId;
  String? gmbLocationId;
  String? media;
  String? mediaFormat;
  String? businessId;
  String? thumbnail;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  Media({
    this.id,
    this.gmbMediaId,
    this.gmbLocationId,
    this.media,
    this.mediaFormat,
    this.businessId,
    this.thumbnail,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["_id"],
    gmbMediaId: json["gmbMediaId"],
    thumbnail: json["thumbnail"],
    gmbLocationId: json["gmbLocationId"],
    media: json["media"],
    mediaFormat: json["mediaFormat"],
    businessId: json["businessId"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gmbMediaId": gmbMediaId,
    "gmbLocationId": gmbLocationId,
    "media": media,
    "mediaFormat": mediaFormat,
    "businessId": businessId,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Post {
  String? id;
  String? gmbPostId;
  String? gmbLocationId;
  String? eventTitle;
  String? eventSummary;
  DateTime? startDate;
  DateTime? endDate;
  String? post;
  String? businessId;
  String? postType;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  Post({
    this.id,
    this.gmbPostId,
    this.gmbLocationId,
    this.eventTitle,
    this.eventSummary,
    this.startDate,
    this.endDate,
    this.post,
    this.businessId,
    this.postType,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["_id"],
    gmbPostId: json["gmbPostId"],
    gmbLocationId: json["gmbLocationId"],
    eventTitle: json["eventTitle"],
    eventSummary: json["eventSummary"],
    startDate: json["startDate"] == null ? null : DateTime.parse(json["startDate"]),
    endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
    post: json["post"],
    businessId: json["businessId"],
    postType: json["postType"],
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gmbPostId": gmbPostId,
    "gmbLocationId": gmbLocationId,
    "eventTitle": eventTitle,
    "eventSummary": eventSummary,
    "startDate": startDate?.toIso8601String(),
    "endDate": endDate?.toIso8601String(),
    "post": post,
    "businessId": businessId,
    "postType": postType,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Product {
  String? id;
  String? gmbProductId;
  int? v;
  String? businessId;
  DateTime? createdAt;
  String? description;
  String? gmbLocationId;
  String? media;
  String? status;
  String? title;
  DateTime? updatedAt;

  Product({
    this.id,
    this.gmbProductId,
    this.v,
    this.businessId,
    this.createdAt,
    this.description,
    this.gmbLocationId,
    this.media,
    this.status,
    this.title,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["_id"],
    gmbProductId: json["gmbProductId"],
    v: json["__v"],
    businessId: json["businessId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    description: json["description"],
    gmbLocationId: json["gmbLocationId"],
    media: json["media"],
    status: json["status"],
    title: json["title"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gmbProductId": gmbProductId,
    "__v": v,
    "businessId": businessId,
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "gmbLocationId": gmbLocationId,
    "media": media,
    "status": status,
    "title": title,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class RegularHour {
  String? day;
  String? openingTime;
  String? closingTime;
  String? id;
  bool? isOpen;

  RegularHour({
    this.day,
    this.openingTime,
    this.closingTime,
    this.id,
    this.isOpen,
  });

  factory RegularHour.fromJson(Map<String, dynamic> json) => RegularHour(
    day: json["day"],
    openingTime: json["openingTime"],
    closingTime: json["closingTime"],
    id: json["_id"],
    isOpen: json["isOpen"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "_id": id,
    'isOpen':isOpen
  };
}

class BusinessService {
  String? id;
  String? gmbLocationId;
  int? v;
  String? businessId;
  DateTime? createdAt;
  String? services;
  DateTime? updatedAt;

  BusinessService({
    this.id,
    this.gmbLocationId,
    this.v,
    this.businessId,
    this.createdAt,
    this.services,
    this.updatedAt,
  });

  factory BusinessService.fromJson(Map<String, dynamic> json) => BusinessService(
    id: json["_id"],
    gmbLocationId: json["gmbLocationId"],
    v: json["__v"],
    businessId: json["businessId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    services: json["services"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "gmbLocationId": gmbLocationId,
    "__v": v,
    "businessId": businessId,
    "createdAt": createdAt?.toIso8601String(),
    "services": services,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}


class AdditionalCategory {
  String? category;
  String? id;

  AdditionalCategory({
    this.category,
    this.id,
  });

  factory AdditionalCategory.fromJson(Map<String, dynamic> json) => AdditionalCategory(
    category: json["category"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "_id": id,
  };
}



class KeyWordForSeo {
  String? keyword;
  String? id;

  KeyWordForSeo({
    this.keyword,
    this.id,
  });

  factory KeyWordForSeo.fromJson(Map<String, dynamic> json) => KeyWordForSeo(
    keyword: json["keyword"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "keyword": keyword,
    "_id": id,
  };
}