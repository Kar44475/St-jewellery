// To parse this JSON data, do
//
//     final schemeaddmodel = schemeaddmodelFromJson(jsonString);

import 'dart:convert';

Schemeaddmodel schemeaddmodelFromJson(String str) =>
    Schemeaddmodel.fromJson(json.decode(str));

String schemeaddmodelToJson(Schemeaddmodel data) => json.encode(data.toJson());

class Schemeaddmodel {
  Schemeaddmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Schemeaddmodel.fromJson(Map<String, dynamic> json) => Schemeaddmodel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    required this.status,
    required this.subscriptionId,
  });

  String status;
  int subscriptionId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        subscriptionId: json["subscriptionId"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subscriptionId": subscriptionId,
      };
}
