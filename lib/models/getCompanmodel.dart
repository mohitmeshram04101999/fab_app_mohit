// To parse this JSON data, do
//
//     final getCompanyResponceModel = getCompanyResponceModelFromJson(jsonString);

import 'dart:convert';

GetCompanyResponceModel getCompanyResponceModelFromJson(String str) => GetCompanyResponceModel.fromJson(json.decode(str));

String getCompanyResponceModelToJson(GetCompanyResponceModel data) => json.encode(data.toJson());

class GetCompanyResponceModel {
  bool? success;
  String? message;
  Company? data;

  GetCompanyResponceModel({
    this.success,
    this.message,
    this.data,
  });

  factory GetCompanyResponceModel.fromJson(Map<String, dynamic> json) => GetCompanyResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Company.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Company {
  String? id;
  String? name;
  String? address;
  String? aboutUs;
  String? email;
  String? website;
  String? favicon;
  String? logo;
  String? returnPolicy;
  String? termsAndConditions;
  String? privacyPolicy;
  int? v;

  Company({
    this.id,
    this.name,
    this.address,
    this.aboutUs,
    this.email,
    this.website,
    this.favicon,
    this.logo,
    this.returnPolicy,
    this.termsAndConditions,
    this.privacyPolicy,
    this.v,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["_id"],
    name: json["name"],
    address: json["address"],
    aboutUs: json["aboutUs"],
    email: json["email"],
    website: json["website"],
    favicon: json["favicon"],
    logo: json["logo"],
    returnPolicy: json["returnPolicy"],
    termsAndConditions: json["termsAndConditions"],
    privacyPolicy: json["privacyPolicy"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "aboutUs": aboutUs,
    "email": email,
    "website": website,
    "favicon": favicon,
    "logo": logo,
    "returnPolicy": returnPolicy,
    "termsAndConditions": termsAndConditions,
    "privacyPolicy": privacyPolicy,
    "__v": v,
  };
}
