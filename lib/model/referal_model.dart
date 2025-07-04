// To parse this JSON data, do
//
//     final referalModal = referalModalFromJson(jsonString);

import 'dart:convert';

ReferalModal referalModalFromJson(String str) =>
    ReferalModal.fromJson(json.decode(str));

String referalModalToJson(ReferalModal data) => json.encode(data.toJson());

class ReferalModal {
  ReferalModal({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory ReferalModal.fromJson(Map<String, dynamic> json) => ReferalModal(
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    required this.status,
    required this.defaultRefaral,
  });

  bool status;
  List<DefaultRefaral> defaultRefaral;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"] == null ? null : json["status"],
        defaultRefaral: List<DefaultRefaral>.from(
            json["default_refaral"].map((x) => DefaultRefaral.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "default_refaral": defaultRefaral == null
            ? null
            : List<dynamic>.from(defaultRefaral.map((x) => x.toJson())),
      };
}

class DefaultRefaral {
  DefaultRefaral({
    required this.id,
    required this.branchId,
    required this.branchName,
    required this.defaultReferal,
    required this.reqMob,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int branchId;
  String branchName;
  String defaultReferal;
  String reqMob;
  dynamic createdAt;
  dynamic updatedAt;

  factory DefaultRefaral.fromJson(Map<String, dynamic> json) => DefaultRefaral(
        id: json["id"] == null ? null : json["id"],
        branchId: json["branchId"] == null ? null : json["branchId"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        defaultReferal:
            json["default_referal"] == null ? null : json["default_referal"],
        reqMob: json["req_mob"] == null ? null : json["req_mob"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "branchId": branchId == null ? null : branchId,
        "branch_name": branchName == null ? null : branchName,
        "default_referal": defaultReferal == null ? null : defaultReferal,
        "req_mob": reqMob == null ? null : reqMob,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
