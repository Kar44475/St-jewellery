// To parse this JSON data, do
//
//     final agentregisterationmodel = agentregisterationmodelFromJson(jsonString);

import 'dart:convert';

Agentregisterationmodel agentregisterationmodelFromJson(String str) => Agentregisterationmodel.fromJson(json.decode(str));

String agentregisterationmodelToJson(Agentregisterationmodel data) => json.encode(data.toJson());

class Agentregisterationmodel {
    Agentregisterationmodel({
        required this.success,
        required this.message,
        required this.data,
    });

    bool success;
    String message;
    Data data;

    factory Agentregisterationmodel.fromJson(Map<String, dynamic> json) => Agentregisterationmodel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        required this.status,
        required this.userId,
        required this.roleId,
    });

    String status;
    int userId;
    int roleId;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        userId: json["userId"],
        roleId: json["roleId"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "roleId": roleId,
    };
}
