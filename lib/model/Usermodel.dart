// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

Usermodel usermodelFromJson(String str) => Usermodel.fromJson(json.decode(str));

String usermodelToJson(Usermodel data) => json.encode(data.toJson());

class Usermodel {
  bool? success;
  String? message;
  Data? data;

  Usermodel({
    this.success,
    this.message,
    this.data,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? status;
  bool? islogin;
  String? token;
  String? userName;
  int? userId;
  String? email;
  int? roleId;
  String? referalId;
  int? branchId;
  List<SubscriptionList>? subscriptionList;

  Data({
    this.status,
    this.islogin,
    this.token,
    this.userName,
    this.userId,
    this.email,
    this.roleId,
    this.referalId,
    this.branchId,
    this.subscriptionList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        islogin: json["islogin"],
        token: json["token"],
        userName: json["userName"],
        userId: json["userId"],
        email: json["Email"],
        roleId: json["roleId"],
        branchId: json["branchId"],
        referalId: json["referalId"],
        subscriptionList: json["subscriptionList"] == null
            ? []
            : List<SubscriptionList>.from(json["subscriptionList"]!
                .map((x) => SubscriptionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "islogin": islogin,
        "token": token,
        "userName": userName,
        "userId": userId,
        "Email": email,
        "roleId": roleId,
        "branchId": branchId,
        "referalId": referalId,
        "subscriptionList": subscriptionList == null
            ? []
            : List<dynamic>.from(subscriptionList!.map((x) => x.toJson())),
      };
}

class SubscriptionList {
  int? id;
  int? branchId;
  int? userId;
  int? schemeId;
  int? schemeAmountId;
  DateTime? startDate;
  dynamic endDate;
  int? subscriptionType;
  int? schemeType;
  DateTime? dateCheck;
  int? status;
  dynamic userSchemeName;
  DateTime? createdAt;
  DateTime? updatedAt;

  SubscriptionList({
    this.id,
    this.branchId,
    this.userId,
    this.schemeId,
    this.schemeAmountId,
    this.startDate,
    this.endDate,
    this.subscriptionType,
    this.schemeType,
    this.dateCheck,
    this.status,
    this.userSchemeName,
    this.createdAt,
    this.updatedAt,
  });

  factory SubscriptionList.fromJson(Map<String, dynamic> json) =>
      SubscriptionList(
        id: json["id"],
        branchId: json["branchId"],
        userId: json["UserId"],
        schemeId: json["SchemeId"],
        schemeAmountId: json["SchemeAmountId"],
        startDate: json["StartDate"] == null
            ? null
            : DateTime.parse(json["StartDate"]),
        endDate: json["EndDate"],
        subscriptionType: json["subscription_type"],
        schemeType: json["scheme_type"],
        dateCheck: json["date_check"] == null
            ? null
            : DateTime.parse(json["date_check"]),
        status: json["status"],
        userSchemeName: json["user_scheme_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "UserId": userId,
        "SchemeId": schemeId,
        "SchemeAmountId": schemeAmountId,
        "StartDate":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "EndDate": endDate,
        "subscription_type": subscriptionType,
        "scheme_type": schemeType,
        "date_check":
            "${dateCheck!.year.toString().padLeft(4, '0')}-${dateCheck!.month.toString().padLeft(2, '0')}-${dateCheck!.day.toString().padLeft(2, '0')}",
        "status": status,
        "user_scheme_name": userSchemeName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
