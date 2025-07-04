// To parse this JSON data, do
//
//     final recepitmodel = recepitmodelFromJson(jsonString);

import 'dart:convert';

Recepitmodel recepitmodelFromJson(String str) =>
    Recepitmodel.fromJson(json.decode(str));

String recepitmodelToJson(Recepitmodel data) => json.encode(data.toJson());

class Recepitmodel {
  bool? success;
  String? message;
  Data? data;

  Recepitmodel({
    this.success,
    this.message,
    this.data,
  });

  factory Recepitmodel.fromJson(Map<String, dynamic> json) => Recepitmodel(
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
  PaymentsDetails? paymentsDetails;
  Rate? rate;

  Data({
    this.paymentsDetails,
    this.rate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        paymentsDetails: json["paymentsDetails"] == null
            ? null
            : PaymentsDetails.fromJson(json["paymentsDetails"]),
        rate: json["rate"] == null ? null : Rate.fromJson(json["rate"]),
      );

  Map<String, dynamic> toJson() => {
        "paymentsDetails": paymentsDetails?.toJson(),
        "rate": rate?.toJson(),
      };
}

class PaymentsDetails {
  int? id;
  int? branchId;
  String? voucherNumber;
  int? userId;
  int? sheduledDateId;
  int? subscriptionId;
  String? gram;
  String? amount;
  String? taransactionId;
  DateTime? paymentDate;
  int? paidBy;
  dynamic note;
  int? paymentMode;
  dynamic paymentMethod;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? name;
  String? phone;
  String? registrationNumber;
  String? schemeName;

  PaymentsDetails({
    this.id,
    this.branchId,
    this.voucherNumber,
    this.userId,
    this.sheduledDateId,
    this.subscriptionId,
    this.gram,
    this.amount,
    this.taransactionId,
    this.paymentDate,
    this.paidBy,
    this.note,
    this.paymentMode,
    this.paymentMethod,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.phone,
    this.registrationNumber,
    this.schemeName,
  });

  factory PaymentsDetails.fromJson(Map<String, dynamic> json) =>
      PaymentsDetails(
        id: json["id"],
        branchId: json["branchId"],
        voucherNumber: json["voucherNumber"],
        userId: json["UserId"],
        sheduledDateId: json["SheduledDateId"],
        subscriptionId: json["subscriptionId"],
        gram: json["gram"],
        amount: json["amount"],
        taransactionId: json["taransactionId"],
        paymentDate: json["paymentDate"] == null
            ? null
            : DateTime.parse(json["paymentDate"]),
        paidBy: json["paidBy"],
        note: json["note"],
        paymentMode: json["paymentMode"],
        paymentMethod: json["payment_method"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        phone: json["phone"],
        registrationNumber: json["registrationNumber"],
        schemeName: json["schemeName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "voucherNumber": voucherNumber,
        "UserId": userId,
        "SheduledDateId": sheduledDateId,
        "subscriptionId": subscriptionId,
        "gram": gram,
        "amount": amount,
        "taransactionId": taransactionId,
        "paymentDate":
            "${paymentDate!.year.toString().padLeft(4, '0')}-${paymentDate!.month.toString().padLeft(2, '0')}-${paymentDate!.day.toString().padLeft(2, '0')}",
        "paidBy": paidBy,
        "note": note,
        "paymentMode": paymentMode,
        "payment_method": paymentMethod,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "name": name,
        "phone": phone,
        "registrationNumber": registrationNumber,
        "schemeName": schemeName,
      };
}

class Rate {
  int? id;
  int? branchId;
  String? name;
  String? amount;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Rate({
    this.id,
    this.branchId,
    this.name,
    this.amount,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Rate.fromJson(Map<String, dynamic> json) => Rate(
        id: json["id"],
        branchId: json["branchId"],
        name: json["name"],
        amount: json["amount"],
        status: json["status"],
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
        "name": name,
        "amount": amount,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
