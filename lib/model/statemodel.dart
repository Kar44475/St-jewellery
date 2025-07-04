// To parse this JSON data, do
//
//     final statemodel = statemodelFromJson(jsonString);

import 'dart:convert';

Statemodel statemodelFromJson(String str) =>
    Statemodel.fromJson(json.decode(str));

String statemodelToJson(Statemodel data) => json.encode(data.toJson());

class Statemodel {
  Statemodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Statemodel.fromJson(Map<String, dynamic> json) => Statemodel(
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
  Data({
    required this.status,
    required this.stateList,
  });

  int status;
  List<StateList> stateList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        stateList: List<StateList>.from(
            json["state_list"].map((x) => StateList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "state_list": stateList == null
            ? null
            : List<dynamic>.from(stateList.map((x) => x.toJson())),
      };
}

class StateList {
  StateList({
    required this.id,
    required this.countryId,
    required this.stateName,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int countryId;
  String stateName;
  DateTime createdAt;
  DateTime updatedAt;

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        id: json["id"],
        countryId: json["countryId"],
        stateName: json["stateName"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "countryId": countryId,
        "stateName": stateName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
