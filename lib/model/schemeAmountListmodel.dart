// To parse this JSON data, do
//
//     final schemeAmountListmodel = schemeAmountListmodelFromJson(jsonString);

import 'dart:convert';

SchemeAmountListmodel schemeAmountListmodelFromJson(String str) =>
    SchemeAmountListmodel.fromJson(json.decode(str));

String schemeAmountListmodelToJson(SchemeAmountListmodel data) =>
    json.encode(data.toJson());

class SchemeAmountListmodel {
  SchemeAmountListmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory SchemeAmountListmodel.fromJson(Map<String, dynamic> json) =>
      SchemeAmountListmodel(
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
    required this.fixed,
    required this.varient,
    required this.termsandcondtion,
  });

  int status;
  List<Fixed> fixed;
  List<Fixed> varient;
  List<Termsandcondtion> termsandcondtion;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        fixed: List<Fixed>.from(json["Fixed"].map((x) => Fixed.fromJson(x))),
        varient:
            List<Fixed>.from(json["Varient"].map((x) => Fixed.fromJson(x))),
        termsandcondtion: List<Termsandcondtion>.from(
            json["termsandcondtion"].map((x) => Termsandcondtion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "Fixed": fixed == null
            ? null
            : List<dynamic>.from(fixed.map((x) => x.toJson())),
        "Varient": varient == null
            ? null
            : List<dynamic>.from(varient.map((x) => x.toJson())),
        "termsandcondtion": termsandcondtion == null
            ? null
            : List<dynamic>.from(termsandcondtion.map((x) => x.toJson())),
      };
}

class Fixed {
  Fixed({
    required this.id,
    required this.schemeId,
    required this.paymentType,
     this.amount,
     this.amountTo,
    required this.termsId,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int schemeId;
  int paymentType;
  String? amount;
  String ? amountTo;
  DateTime createdAt;
  int termsId;
  DateTime updatedAt;

  factory Fixed.fromJson(Map<String, dynamic> json) => Fixed(
        id: json["id"],
        schemeId: json["SchemeId"],
        paymentType: json["payment_type"],
        amount: json["amount"]??"",
        amountTo: json["amount_to"]??"",
        termsId: json["termsId"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "SchemeId": schemeId,
        "payment_type": paymentType,
        "amount": amount,
        "amount_to": amountTo,
        "termsId": termsId,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class Termsandcondtion {
  Termsandcondtion({
    required this.id,
    required this.branchId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int branchId;
  String title;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  factory Termsandcondtion.fromJson(Map<String, dynamic> json) =>
      Termsandcondtion(
        id: json["id"],
        branchId: json["branchId"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "title": title,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
