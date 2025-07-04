// To parse this JSON data, do
//
//     final districtmodel = districtmodelFromJson(jsonString);

import 'dart:convert';

Districtmodel districtmodelFromJson(String str) =>
    Districtmodel.fromJson(json.decode(str));

String districtmodelToJson(Districtmodel data) => json.encode(data.toJson());

class Districtmodel {
  Districtmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Districtmodel.fromJson(Map<String, dynamic> json) => Districtmodel(
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
    required this.districtsList,
  });

  int status;
  List<DistrictsList> districtsList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        districtsList: List<DistrictsList>.from(
            json["districts_list"].map((x) => DistrictsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "districts_list": districtsList == null
            ? null
            : List<dynamic>.from(districtsList.map((x) => x.toJson())),
      };
}

class DistrictsList {
  DistrictsList({
    required this.id,
    required this.stateId,
    required this.districtName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int stateId;
  String districtName;
  DateTime createdAt;
  DateTime updatedAt;

  factory DistrictsList.fromJson(Map<String, dynamic> json) => DistrictsList(
        id: json["id"],
        stateId: json["stateId"],
        districtName: json["districtName"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "stateId": stateId,
        "districtName": districtName,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
