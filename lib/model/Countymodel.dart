// To parse this JSON data, do
//
//     final countrymodel = countrymodelFromJson(jsonString);

import 'dart:convert';

Countrymodel countrymodelFromJson(String str) =>
    Countrymodel.fromJson(json.decode(str));

String countrymodelToJson(Countrymodel data) => json.encode(data.toJson());

class Countrymodel {
  Countrymodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Countrymodel.fromJson(Map<String, dynamic> json) => Countrymodel(
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
  Data({required this.status, required this.countryList});

  int status;
  List<CountryList> countryList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    countryList: List<CountryList>.from(
      json["country_list"].map((x) => CountryList.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "country_list": countryList == null
        ? null
        : List<dynamic>.from(countryList.map((x) => x.toJson())),
  };
}

class CountryList {
  CountryList({
    required this.id,
    required this.sortname,
    required this.countryName,
    required this.phonecode,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String sortname;
  String countryName;
  String phonecode;
  DateTime createdAt;
  DateTime updatedAt;

  factory CountryList.fromJson(Map<String, dynamic> json) => CountryList(
    id: json["id"],
    sortname: json["sortname"],
    countryName: json["countryName"],
    phonecode: json["phonecode"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sortname": sortname,
    "countryName": countryName,
    "phonecode": phonecode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
