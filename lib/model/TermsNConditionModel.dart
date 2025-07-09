// To parse this JSON data, do
//
//     final termsNConditionModel = termsNConditionModelFromJson(jsonString);

import 'dart:convert';

TermsNConditionModel termsNConditionModelFromJson(String str) =>
    TermsNConditionModel.fromJson(json.decode(str));

String termsNConditionModelToJson(TermsNConditionModel data) =>
    json.encode(data.toJson());

class TermsNConditionModel {
  bool success;
  String message;
  Data data;

  TermsNConditionModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory TermsNConditionModel.fromJson(Map<String, dynamic> json) =>
      TermsNConditionModel(
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
  List<Term> terms;

  Data({required this.status, required this.terms});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    terms: List<Term>.from(json["terms"].map((x) => Term.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "terms": List<dynamic>.from(terms.map((x) => x.toJson())),
  };
}

class Term {
  int termsId;
  String title;
  String description;

  Term({required this.termsId, required this.title, required this.description});

  factory Term.fromJson(Map<String, dynamic> json) => Term(
    termsId: json["termsId"],
    title: json["title"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "termsId": termsId,
    "title": title,
    "description": description,
  };
}
