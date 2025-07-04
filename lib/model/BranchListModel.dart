// To parse this JSON data, do
//
//     final branchListModel = branchListModelFromJson(jsonString);

import 'dart:convert';

BranchListModel branchListModelFromJson(String str) =>
    BranchListModel.fromJson(json.decode(str));

String branchListModelToJson(BranchListModel data) =>
    json.encode(data.toJson());

class BranchListModel {
  bool success;
  String message;
  Data data;

  BranchListModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BranchListModel.fromJson(Map<String, dynamic> json) =>
      BranchListModel(
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
  bool status;
  List<Branch> branches;

  Data({
    required this.status,
    required this.branches,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        branches:
            List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
      };
}

class Branch {
  int id;
  String? branchId;
  dynamic userId;
  String name;
  String email;
  dynamic emailVerifiedAt;
  dynamic roleId;
  dynamic phone;
  DateTime createdAt;
  DateTime updatedAt;
  String? referalId;

  Branch({
    required this.id,
    required this.branchId,
    required this.userId,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.roleId,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    this.referalId,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        branchId: json["branchId"],
        userId: json["userId"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["roleId"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        referalId: json["referalId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "userId": userId,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "roleId": roleId,
        "phone": phone,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "referalId": referalId,
      };
}
