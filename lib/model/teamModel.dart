// To parse this JSON data, do
//
//     final teamModel = teamModelFromJson(jsonString);

import 'dart:convert';

TeamModel teamModelFromJson(String str) => TeamModel.fromJson(json.decode(str));

String teamModelToJson(TeamModel data) => json.encode(data.toJson());

class TeamModel {
  bool? success;
  String? message;
  Data? data;

  TeamModel({this.success, this.message, this.data});

  factory TeamModel.fromJson(Map<String, dynamic> json) => TeamModel(
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
  bool? status;
  List<BankDetail>? bankDetails;

  Data({this.status, this.bankDetails});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    bankDetails: json["bank_details"] == null
        ? []
        : List<BankDetail>.from(
            json["bank_details"]!.map((x) => BankDetail.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "bank_details": bankDetails == null
        ? []
        : List<dynamic>.from(bankDetails!.map((x) => x.toJson())),
  };
}

class BankDetail {
  int? id;
  int? branchId;
  String? name;
  String? phone;
  String? email;
  String? designation;
  dynamic description;
  dynamic image;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  BankDetail({
    this.id,
    this.branchId,
    this.name,
    this.phone,
    this.email,
    this.designation,
    this.description,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
    id: json["id"],
    branchId: json["branchId"],
    name: json["Name"],
    phone: json["phone"],
    email: json["email"],
    designation: json["designation"],
    description: json["description"],
    image: json["image"],
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
    "Name": name,
    "phone": phone,
    "email": email,
    "designation": designation,
    "description": description,
    "image": image,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
