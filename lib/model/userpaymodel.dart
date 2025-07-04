// To parse this JSON data, do
//
//     final userpaymodel = userpaymodelFromJson(jsonString);

import 'dart:convert';

Userpaymodel userpaymodelFromJson(String str) =>
    Userpaymodel.fromJson(json.decode(str));

String userpaymodelToJson(Userpaymodel data) => json.encode(data.toJson());

class Userpaymodel {
  Userpaymodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Userpaymodel.fromJson(Map<String, dynamic> json) => Userpaymodel(
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
