// To parse this JSON data, do
//
//     final saveSchemeModel = saveSchemeModelFromJson(jsonString);

import 'dart:convert';

SaveSchemeModel saveSchemeModelFromJson(String str) =>
    SaveSchemeModel.fromJson(json.decode(str));

String saveSchemeModelToJson(SaveSchemeModel data) =>
    json.encode(data.toJson());

class SaveSchemeModel {
  SaveSchemeModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory SaveSchemeModel.fromJson(Map<String, dynamic> json) =>
      SaveSchemeModel(
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
  });

  bool status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
