

import 'dart:convert';

Aboutusmodel aboutusmodelFromJson(String str) =>
    Aboutusmodel.fromJson(json.decode(str));

String aboutusmodelToJson(Aboutusmodel data) => json.encode(data.toJson());

class Aboutusmodel {
  Aboutusmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Aboutusmodel.fromJson(Map<String, dynamic> json) => Aboutusmodel(
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
    required this.aboutOurJewellery,
  });

  AboutUs aboutOurJewellery;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        aboutOurJewellery:
           AboutUs.fromJson(json["AboutUs"]),
      );

  Map<String, dynamic> toJson() => {
        "AboutUs": aboutOurJewellery == null ? null : aboutOurJewellery.toJson(),
      };
}

class AboutUs {
  AboutUs({
    required this.id,
    required this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  factory AboutUs.fromJson(Map<String, dynamic> json) => AboutUs(
        id: json["id"],
        description: json["description"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
