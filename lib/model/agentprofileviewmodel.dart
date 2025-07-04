// To parse this JSON data, do
//
//     final agentprofileviewmodel = agentprofileviewmodelFromJson(jsonString);

import 'dart:convert';

Agentprofileviewmodel agentprofileviewmodelFromJson(String str) =>
    Agentprofileviewmodel.fromJson(json.decode(str));

String agentprofileviewmodelToJson(Agentprofileviewmodel data) =>
    json.encode(data.toJson());

class Agentprofileviewmodel {
  bool? success;
  String? message;
  Data? data;

  Agentprofileviewmodel({
    this.success,
    this.message,
    this.data,
  });

  factory Agentprofileviewmodel.fromJson(Map<String, dynamic> json) =>
      Agentprofileviewmodel(
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
  UserId? userId;

  Data({
    this.status,
    this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId?.toJson(),
      };
}

class UserId {
  int? id;
  int? branchId;
  int? userId;
  String? agentName;
  String? agentCode;
  String? phone;
  String? email;
  String? adhaar;
  String? panNumber;
  String? address;
  String? image;
  String? referalId;
  dynamic referalFrom;
  dynamic point;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserId({
    this.id,
    this.branchId,
    this.userId,
    this.agentName,
    this.agentCode,
    this.phone,
    this.email,
    this.adhaar,
    this.panNumber,
    this.address,
    this.image,
    this.referalId,
    this.referalFrom,
    this.point,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"],
        branchId: json["branchId"],
        userId: json["UserId"],
        agentName: json["agentName"],
        agentCode: json["agent_code"],
        phone: json["phone"],
        email: json["email"] ?? "",
        adhaar: json["adhaar"] ?? "",
        panNumber: json["panNumber"] ?? "",
        address: json["address"] ?? "",
        image: json["image"],
        referalId: json["referalId"],
        referalFrom: json["referalFrom"],
        point: json["point"],
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
        "UserId": userId,
        "agentName": agentName,
        "agent_code": agentCode,
        "phone": phone,
        "email": email,
        "adhaar": adhaar,
        "panNumber": panNumber,
        "address": address,
        "image": image,
        "referalId": referalId,
        "referalFrom": referalFrom,
        "point": point,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
