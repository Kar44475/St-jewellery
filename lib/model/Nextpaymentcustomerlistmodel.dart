// To parse this JSON data, do
//
//     final nextpaymentcustomerlistmodel = nextpaymentcustomerlistmodelFromJson(jsonString);

import 'dart:convert';

Nextpaymentcustomerlistmodel nextpaymentcustomerlistmodelFromJson(String str) =>
    Nextpaymentcustomerlistmodel.fromJson(json.decode(str));

String nextpaymentcustomerlistmodelToJson(Nextpaymentcustomerlistmodel data) =>
    json.encode(data.toJson());

class Nextpaymentcustomerlistmodel {
  bool? success;
  String? message;
  Data? data;

  Nextpaymentcustomerlistmodel({this.success, this.message, this.data});

  factory Nextpaymentcustomerlistmodel.fromJson(Map<String, dynamic> json) =>
      Nextpaymentcustomerlistmodel(
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
  List<CustomerList>? customerList;

  Data({this.status, this.customerList});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    customerList: json["CustomerList"] == null
        ? []
        : List<CustomerList>.from(
            json["CustomerList"]!.map((x) => CustomerList.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "CustomerList": customerList == null
        ? []
        : List<dynamic>.from(customerList!.map((x) => x.toJson())),
  };
}

class CustomerList {
  int? userId;
  String? name;
  String? registrationNumber;
  String? phone;
  int? subscriptionId;

  CustomerList({
    this.userId,
    this.name,
    this.registrationNumber,
    this.phone,
    this.subscriptionId,
  });

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
    userId: json["UserId"],
    name: json["name"],
    registrationNumber: json["registrationNumber"],
    phone: json["phone"],
    subscriptionId: json["subscriptionId"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "name": name,
    "registrationNumber": registrationNumber,
    "phone": phone,
    "subscriptionId": subscriptionId,
  };
}
