// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

PrivacyPolicyModel privacyPolicyModelFromJson(String str) =>
    PrivacyPolicyModel.fromJson(json.decode(str));

String privacyPolicyModelToJson(PrivacyPolicyModel data) =>
    json.encode(data.toJson());

class PrivacyPolicyModel {
  bool success;
  String message;
  Data data;

  PrivacyPolicyModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyModel(
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
  List<Privacy> privacy;

  Data({required this.status, required this.privacy});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    privacy: List<Privacy>.from(
      json["privacy"].map((x) => Privacy.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "privacy": List<dynamic>.from(privacy.map((x) => x.toJson())),
  };
}

class Privacy {
  int id;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  Privacy({
    required this.id,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Privacy.fromJson(Map<String, dynamic> json) => Privacy(
    id: json["id"],
    description: json["description"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
