
// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

// import 'dart:convert';
//
// UserData userFromJson(String str) => UserData.fromJson(json.decode(str));
//
// String userToJson(UserData data) => json.encode(data.toJson());
//
// class UserData {
//   String? id;
//   String? name;
//   String? email;
//   int? mobile;
//   String? profileImage;
//   String? otp;
//   String? userType;
//   bool? disable;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   int? v;
//   String? token;
//   String? userImage;
//
//   UserData({
//     this.id,
//     this.name,
//     this.email,
//     this.mobile,
//     this.otp,
//     this.userType,
//     this.disable,
//     this.createdAt,
//     this.updatedAt,
//     this.profileImage,
//     this.v,
//     this.token,
//     this.userImage
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) => UserData(
//     id: json["_id"],
//     name: json["name"],
//     profileImage: json["image"],
//     email: json["email"],
//     mobile: json["mobile"],
//     otp: json["otp"],
//     userType: json["userType"],
//     disable: json["disable"],
//     createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
//     updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
//     v: json["__v"],
//     token: json["token"],
//     userImage: json["userImage"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "_id": id,
//     "name": name,
//     "email": email,
//     "mobile": mobile,
//     "otp": otp,
//     "userType": userType,
//     "disable": disable,
//     "createdAt": createdAt?.toIso8601String(),
//     "updatedAt": updatedAt?.toIso8601String(),
//     "__v": v,
//     "token": token,
//     'userImage':userImage
//   };
//
//   setToken(String? tok)
//   {
//     token = tok;
//   }
// }




// To parse this JSON data, do
//
//     final userResponceModel = userResponceModelFromJson(jsonString);

import 'dart:convert';

import 'package:fab_app/models/getAllPlanResponceModel.dart';

UserResponceModel userResponceModelFromJson(String str) => UserResponceModel.fromJson(json.decode(str));

String userResponceModelToJson(UserResponceModel data) => json.encode(data.toJson());

class UserResponceModel {
  bool? success;
  String? message;
  User? data;



  UserResponceModel({
    this.success,
    this.message,
    this.data,

  });

  factory UserResponceModel.fromJson(Map<String, dynamic> json) => UserResponceModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : User.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class User {
  UserData? user;
  Subscription? subscription;
  String? accessToken;


  User({
    this.user,
    this.subscription,
    this.accessToken
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    accessToken: json["accessToken"],
    user: json["user"] == null ? null : UserData.fromJson(json["user"]),
    subscription: json["subscription"] == null ? null : Subscription.fromJson(json["subscription"]),
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "subscription": subscription?.toJson(),
  };
}

class Subscription {
  bool? isActivePlan;
  Plan? planDetails;
  bool? isPlanExpired;

  Subscription({
    this.isActivePlan,
    this.planDetails,
    this.isPlanExpired,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    isActivePlan: json["isActivePlan"],
    planDetails: json["planDetails"] == null ? null : Plan.fromJson(json["planDetails"]),
    isPlanExpired: json["isPlanExpired"],
  );

  Map<String, dynamic> toJson() => {
    "isActivePlan": isActivePlan,
    "planDetails": planDetails?.toJson(),
    "isPlanExpired": isPlanExpired,
  };
}




class UserData {
  String? id;
  String? name;
  String? email;
  int? mobile;
  String? profileImage;
  String? otp;
  String? userType;
  bool? disable;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? token;
  String? userImage;

  UserData({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.otp,
    this.userType,
    this.disable,
    this.createdAt,
    this.updatedAt,
    this.profileImage,
    this.v,
    this.token,
    this.userImage
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["_id"],
    name: json["name"],
    profileImage: json["image"],
    email: json["email"],
    mobile: json["mobile"],
    otp: json["otp"],
    userType: json["userType"],
    disable: json["disable"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    token: json["token"],
    userImage: json["userImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "otp": otp,
    "userType": userType,
    "disable": disable,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "token": token,
    'userImage':userImage
  };

  setToken(String? tok)
  {
    token = tok;
  }
}


