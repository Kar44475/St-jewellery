// To parse this JSON data, do
//
//     final dashboardmodel = dashboardmodelFromJson(jsonString);

import 'dart:convert';

Dashboardmodel dashboardmodelFromJson(String str) =>
    Dashboardmodel.fromJson(json.decode(str));

String dashboardmodelToJson(Dashboardmodel data) => json.encode(data.toJson());

class Dashboardmodel {
  bool success;
  String message;
  Data data;

  Dashboardmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Dashboardmodel.fromJson(Map<String, dynamic> json) => Dashboardmodel(
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
  Versions versions;
  List<Image> bannerImage;
  List<Image> schemeImage;
  BannerContent bannerContent;
  SchemeDetails schemeDetails;
  String todayRate;
  String gramPrevious;
  String silverTodayRate;
  String silverPrevious;

  Data({
    required this.versions,
    required this.bannerImage,
    required this.schemeImage,
    required this.bannerContent,
    required this.schemeDetails,
    required this.todayRate,
    required this.gramPrevious,
    required this.silverTodayRate,
    required this.silverPrevious,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        versions: Versions.fromJson(json["versions"]),
        bannerImage: List<Image>.from(
            json["banner_image"].map((x) => Image.fromJson(x))),
        schemeImage: List<Image>.from(
            json["scheme_image"].map((x) => Image.fromJson(x))),
        bannerContent: BannerContent.fromJson(json["banner_content"]),
        schemeDetails: SchemeDetails.fromJson(json["scheme_details"]),
        todayRate: json["todayRate"],
        gramPrevious: json["gram_previous"],
        silverTodayRate: json["silver_todayRate"],
        silverPrevious: json["silver_previous"],
      );

  Map<String, dynamic> toJson() => {
        "versions": versions.toJson(),
        "banner_image": List<dynamic>.from(bannerImage.map((x) => x.toJson())),
        "scheme_image": List<dynamic>.from(schemeImage.map((x) => x.toJson())),
        "banner_content": bannerContent.toJson(),
        "scheme_details": schemeDetails.toJson(),
        "todayRate": todayRate,
        "gram_previous": gramPrevious,
        "silver_todayRate": silverTodayRate,
        "silver_previous": silverPrevious,
      };
}

class BannerContent {
  int id;
  int branchId;
  String bannerContent;
  dynamic schemeContent;
  String status;
  dynamic createdAt;
  dynamic updatedAt;

  BannerContent({
    required this.id,
    required this.branchId,
    required this.bannerContent,
    required this.schemeContent,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BannerContent.fromJson(Map<String, dynamic> json) => BannerContent(
        id: json["id"],
        branchId: json["branchId"],
        bannerContent: json["banner_content"],
        schemeContent: json["scheme_content"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "banner_content": bannerContent,
        "scheme_content": schemeContent,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Image {
  int id;
  int branchId;
  String bannerImage;
  int imageType;
  String status;
  dynamic createdAt;
  dynamic updatedAt;

  Image({
    required this.id,
    required this.branchId,
    required this.bannerImage,
    required this.imageType,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        branchId: json["branchId"],
        bannerImage: json["banner_image"],
        imageType: json["image_type"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "branchId": branchId,
        "banner_image": bannerImage,
        "image_type": imageType,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class SchemeDetails {
  int id;
  int branchId;
  String title;
  String description;
  dynamic createdAt;
  dynamic updatedAt;

  SchemeDetails({
    required this.id,
    required this.branchId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SchemeDetails.fromJson(Map<String, dynamic> json) => SchemeDetails(
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

class Versions {
  int android;
  int ios;

  Versions({
    required this.android,
    required this.ios,
  });

  factory Versions.fromJson(Map<String, dynamic> json) => Versions(
        android: json["android"],
        ios: json["ios"],
      );

  Map<String, dynamic> toJson() => {
        "android": android,
        "ios": ios,
      };
}
