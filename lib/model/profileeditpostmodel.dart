// To parse this JSON data, do
//
//     final profileditpostmodel = profileditpostmodelFromJson(jsonString);

import 'dart:convert';

Profileditpostmodel profileditpostmodelFromJson(String str) =>
    Profileditpostmodel.fromJson(json.decode(str));

String profileditpostmodelToJson(Profileditpostmodel data) =>
    json.encode(data.toJson());

class Profileditpostmodel {
  Profileditpostmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Profileditpostmodel.fromJson(Map<String, dynamic> json) =>
      Profileditpostmodel(
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

  String status;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
