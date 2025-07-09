// To parse this JSON data, do
//
//     final offermodel = offermodelFromJson(jsonString);

import 'dart:convert';

Offermodel offermodelFromJson(String str) =>
    Offermodel.fromJson(json.decode(str));

String offermodelToJson(Offermodel data) => json.encode(data.toJson());

class Offermodel {
  bool success;
  String message;
  Data data;

  Offermodel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Offermodel.fromJson(Map<String, dynamic> json) => Offermodel(
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
  List<Offer> offers;

  Data({required this.status, required this.offers});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    offers: List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}

class Offer {
  int id;
  String productName;
  String offerCode;
  String title;
  String description;
  String image;
  bool likeStatus;
  int totalCount;

  Offer({
    required this.id,
    required this.productName,
    required this.offerCode,
    required this.title,
    required this.description,
    required this.image,
    required this.likeStatus,
    required this.totalCount,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    id: json["id"],
    productName: json["product_name"],
    offerCode: json["offer_code"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    likeStatus: json["like_status"],
    totalCount: json["total_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product_name": productName,
    "offer_code": offerCode,
    "title": title,
    "description": description,
    "image": image,
    "like_status": likeStatus,
    "total_count": totalCount,
  };
}
