// To parse this JSON data, do
//
//     final agentpendingmodel = agentpendingmodelFromJson(jsonString);

import 'dart:convert';

Agentpendingmodel agentpendingmodelFromJson(String str) =>
    Agentpendingmodel.fromJson(json.decode(str));

String agentpendingmodelToJson(Agentpendingmodel data) =>
    json.encode(data.toJson());

class Agentpendingmodel {
  bool? success;
  String? message;
  Data? data;

  Agentpendingmodel({
    this.success,
    this.message,
    this.data,
  });

  factory Agentpendingmodel.fromJson(Map<String, dynamic> json) =>
      Agentpendingmodel(
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
  List<Adminpayment>? adminpayment;
  int? pending;

  Data({
    this.adminpayment,
    this.pending,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        adminpayment: json["Adminpayment"] == null
            ? []
            : List<Adminpayment>.from(
                json["Adminpayment"]!.map((x) => Adminpayment.fromJson(x))),
        pending: json["Pending"],
      );

  Map<String, dynamic> toJson() => {
        "Adminpayment": adminpayment == null
            ? []
            : List<dynamic>.from(adminpayment!.map((x) => x.toJson())),
        "Pending": pending,
      };
}

class Adminpayment {
  int? id;
  int? branchId;
  int? agentId;
  DateTime? fromdate;
  DateTime? todate;
  int? pendingamount;
  dynamic notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  Adminpayment({
    this.id,
    this.branchId,
    this.agentId,
    this.fromdate,
    this.todate,
    this.pendingamount,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Adminpayment.fromJson(Map<String, dynamic> json) => Adminpayment(
        id: json["id"],
        branchId: json["branchId"],
        agentId: json["AgentId"],
        fromdate:
            json["fromdate"] == null ? null : DateTime.parse(json["fromdate"]),
        todate: json["todate"] == null ? null : DateTime.parse(json["todate"]),
        pendingamount: json["pendingamount"],
        notes: json["notes"],
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
        "AgentId": agentId,
        "fromdate":
            "${fromdate!.year.toString().padLeft(4, '0')}-${fromdate!.month.toString().padLeft(2, '0')}-${fromdate!.day.toString().padLeft(2, '0')}",
        "todate":
            "${todate!.year.toString().padLeft(4, '0')}-${todate!.month.toString().padLeft(2, '0')}-${todate!.day.toString().padLeft(2, '0')}",
        "pendingamount": pendingamount,
        "notes": notes,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
