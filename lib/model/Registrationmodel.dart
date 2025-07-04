// To parse this JSON data, do
//
//     final registrationmodel = registrationmodelFromJson(jsonString);

import 'dart:convert';

Registrationmodel registrationmodelFromJson(String str) => Registrationmodel.fromJson(json.decode(str));

String registrationmodelToJson(Registrationmodel data) => json.encode(data.toJson());

class Registrationmodel {
    bool? success;
    String? message;
    Data? data;

    Registrationmodel({
        this.success,
        this.message,
        this.data,
    });

    factory Registrationmodel.fromJson(Map<String, dynamic> json) => Registrationmodel(
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
    int? userId;
    int? roleId;
    String? token;

    Data({
        this.status,
        this.userId,
        this.roleId,
        this.token,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        userId: json["userId"],
        roleId: json["roleId"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "roleId": roleId,
        "token": token,
    };
}
