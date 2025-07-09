// To parse this JSON data, do
//
//     final bankdetailsmodel = bankdetailsmodelFromJson(jsonString);

import 'dart:convert';

Bankdetailsmodel bankdetailsmodelFromJson(String str) =>
    Bankdetailsmodel.fromJson(json.decode(str));

String bankdetailsmodelToJson(Bankdetailsmodel data) =>
    json.encode(data.toJson());

class Bankdetailsmodel {
  Bankdetailsmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Bankdetailsmodel.fromJson(Map<String, dynamic> json) =>
      Bankdetailsmodel(
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
    required this.bankDetails,
    required this.upiDetails,
  });

  bool status;
  List<Detail> bankDetails;
  List<Detail> upiDetails;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    bankDetails: List<Detail>.from(
      json["bank_details"].map((x) => Detail.fromJson(x)),
    ),
    upiDetails: List<Detail>.from(
      json["upi_details"].map((x) => Detail.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "bank_details": bankDetails == null
        ? null
        : List<dynamic>.from(bankDetails.map((x) => x.toJson())),
    "upi_details": upiDetails == null
        ? null
        : List<dynamic>.from(upiDetails.map((x) => x.toJson())),
  };
}

class Detail {
  Detail({
    required this.id,
    required this.branchId,
    this.bankName,
    this.beneficiaryName,
    this.ifscCode,
    this.accNo,
    this.upiId,
    this.mobNo,
    required this.type,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int branchId;
  String? bankName;
  String? beneficiaryName;
  String? ifscCode;
  String? accNo;
  String? upiId;
  String? mobNo;
  int type;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    id: json["id"],
    branchId: json["branchId"],
    bankName: json["bank_name"] ?? "",
    beneficiaryName: json["beneficiaryName"] ?? "",
    ifscCode: json["ifsc_Code"] ?? "",
    accNo: json["acc_no"] ?? "",
    upiId: json["Upi_id"] ?? "",
    mobNo: json["mob_no"] ?? "",
    type: json["type"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branchId": branchId,
    "bank_name": bankName,
    "beneficiaryName": beneficiaryName,
    "ifsc_Code": ifscCode,
    "acc_no": accNo,
    "Upi_id": upiId,
    "mob_no": mobNo,
    "type": type,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
