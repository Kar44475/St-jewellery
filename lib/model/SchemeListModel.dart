// To parse this JSON data, do
//
//     final schemeListmodel = schemeListmodelFromJson(jsonString);

import 'dart:convert';

SchemeListmodel schemeListmodelFromJson(String str) => SchemeListmodel.fromJson(json.decode(str));

String schemeListmodelToJson(SchemeListmodel data) => json.encode(data.toJson());

class SchemeListmodel {
  bool? success;
  String? message;
  Data? data;

  SchemeListmodel({
    this.success,
    this.message,
    this.data,
  });

  factory SchemeListmodel.fromJson(Map<String, dynamic> json) => SchemeListmodel(
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
  int? status;
  List<SchemeList>? schemeList;

  Data({
    this.status,
    this.schemeList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    schemeList: json["SchemeList"] == null ? [] : List<SchemeList>.from(json["SchemeList"]!.map((x) => SchemeList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "SchemeList": schemeList == null ? [] : List<dynamic>.from(schemeList!.map((x) => x.toJson())),
  };
}

class SchemeList {
  int? id;
  int? branchId;
  String? schemeName;
  int? paymentIntervel;
  int? totalInstallment;
  int? status;
  int? schemeType;
  dynamic checkPaymentInterval;
  DateTime? createdAt;
  DateTime? updatedAt;

  SchemeList({
    this.id,
    this.branchId,
    this.schemeName,
    this.paymentIntervel,
    this.totalInstallment,
    this.status,
    this.schemeType,
    this.checkPaymentInterval,
    this.createdAt,
    this.updatedAt,
  });

  factory SchemeList.fromJson(Map<String, dynamic> json) => SchemeList(
    id: json["id"],
    branchId: json["branchId"],
    schemeName: json["schemeName"],
    paymentIntervel: json["paymentIntervel"],
    totalInstallment: json["totalInstallment"],
    status: json["status"],
    schemeType: json["scheme_type"],
    checkPaymentInterval: json["check_payment_interval"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branchId": branchId,
    "schemeName": schemeName,
    "paymentIntervel": paymentIntervel,
    "totalInstallment": totalInstallment,
    "status": status,
    "scheme_type": schemeType,
    "check_payment_interval": checkPaymentInterval,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
