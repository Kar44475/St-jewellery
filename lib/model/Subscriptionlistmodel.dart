// To parse this JSON data, do
//
//     final subscriptionlistmodel = subscriptionlistmodelFromJson(jsonString);

import 'dart:convert';

Subscriptionlistmodel subscriptionlistmodelFromJson(String str) =>
    Subscriptionlistmodel.fromJson(json.decode(str));

String subscriptionlistmodelToJson(Subscriptionlistmodel data) =>
    json.encode(data.toJson());

class Subscriptionlistmodel {
  bool success;
  String message;
  Data data;

  Subscriptionlistmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Subscriptionlistmodel.fromJson(Map<String, dynamic> json) =>
      Subscriptionlistmodel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  String status;
  List<SubscriptionList> subscriptionList;

  Data({
    required this.status,
    required this.subscriptionList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        subscriptionList: List<SubscriptionList>.from(
            json["subscriptionList"].map((x) => SubscriptionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subscriptionList":
            List<dynamic>.from(subscriptionList.map((x) => x.toJson())),
      };
}

class SubscriptionList {
  int id;
  int userId;
  int schemeId;
  int schemeAmountId;
  DateTime startDate;
  dynamic endDate;
  int status;
  String? schemeName;
  String? schemAmount;
  String? amountTo;
  int subscriptionType;

  SubscriptionList({
    required this.id,
    required this.userId,
    required this.schemeId,
    required this.schemeAmountId,
    required this.startDate,
    required this.endDate,
    required this.status,
     this.schemeName,
     this.schemAmount,
     this.amountTo,
    required this.subscriptionType,
  });

  factory SubscriptionList.fromJson(Map<String, dynamic> json) =>
      SubscriptionList(
        id: json["id"],
        userId: json["UserId"],
        schemeId: json["SchemeId"],
        schemeAmountId: json["SchemeAmountId"],
        startDate: DateTime.parse(json["StartDate"]),
        endDate: json["EndDate"],
        status: json["status"],
        schemeName: json["schemeName"]??"",
        schemAmount: json["schem_amount"]??"",
        amountTo: json["amount_to"]??"",
        subscriptionType: json["subscription_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "UserId": userId,
        "SchemeId": schemeId,
        "SchemeAmountId": schemeAmountId,
        "StartDate":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "EndDate": endDate,
        "status": status,
        "schemeName": schemeName,
        "schem_amount": schemAmount,
        "amount_to": amountTo,
        "subscription_type": subscriptionType,
      };
}
