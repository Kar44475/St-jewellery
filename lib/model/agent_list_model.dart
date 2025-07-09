// To parse this JSON data, do
//
//     final agentcustomermodel = agentcustomermodelFromJson(jsonString);

import 'dart:convert';

Agentcustomermodel agentcustomermodelFromJson(String str) =>
    Agentcustomermodel.fromJson(json.decode(str));

String agentcustomermodelToJson(Agentcustomermodel data) =>
    json.encode(data.toJson());

class Agentcustomermodel {
  bool? success;
  String? message;
  Data? data;

  Agentcustomermodel({this.success, this.message, this.data});

  factory Agentcustomermodel.fromJson(Map<String, dynamic> json) =>
      Agentcustomermodel(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  Versions? versions;
  String? status;
  List<CustomerList>? customerList;

  Data({this.versions, this.status, this.customerList});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    versions: json["versions"] == null
        ? null
        : Versions.fromJson(json["versions"]),
    status: json["status"],
    customerList: json["CustomerList"] == null
        ? []
        : List<CustomerList>.from(
            json["CustomerList"]!.map((x) => CustomerList.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "versions": versions?.toJson(),
    "status": status,
    "CustomerList": customerList == null
        ? []
        : List<dynamic>.from(customerList!.map((x) => x.toJson())),
  };
}

class CustomerList {
  int? id;
  String? registrationNumber;
  int? userId;
  int? branchId;
  String? name;
  String? email;
  String? address;
  String? phone;
  DateTime? dob;
  String? aCNumber;
  String? adhaarcard;
  String? pancard;
  String? nominee;
  String? nomineeRelation;
  String? nomineePhone;
  String? pincode;
  int? district;
  int? state;
  int? country;
  String? image;
  String? referalId;
  String? referalFrom;
  String? point;
  int? userType;
  int? agentId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CustomerList({
    this.id,
    this.registrationNumber,
    this.userId,
    this.branchId,
    this.name,
    this.email,
    this.address,
    this.phone,
    this.dob,
    this.aCNumber,
    this.adhaarcard,
    this.pancard,
    this.nominee,
    this.nomineeRelation,
    this.nomineePhone,
    this.pincode,
    this.district,
    this.state,
    this.country,
    this.image,
    this.referalId,
    this.referalFrom,
    this.point,
    this.userType,
    this.agentId,
    this.createdAt,
    this.updatedAt,
  });

  factory CustomerList.fromJson(Map<String, dynamic> json) => CustomerList(
    id: json["id"],
    registrationNumber: json["registrationNumber"],
    userId: json["UserId"],
    branchId: json["branchId"],
    name: json["name"],
    email: json["email"],
    address: json["address"],
    phone: json["phone"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    aCNumber: json["a_c_number"],
    adhaarcard: json["adhaarcard"],
    pancard: json["pancard"],
    nominee: json["nominee"],
    nomineeRelation: json["nominee_relation"],
    nomineePhone: json["nominee_phone"],
    pincode: json["pincode"],
    district: json["district"],
    state: json["state"],
    country: json["country"],
    image: json["image"],
    referalId: json["referalId"],
    referalFrom: json["referalFrom"],
    point: json["point"],
    userType: json["userType"],
    agentId: json["agentId"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "registrationNumber": registrationNumber,
    "UserId": userId,
    "branchId": branchId,
    "name": name,
    "email": email,
    "address": address,
    "phone": phone,
    "dob":
        "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "a_c_number": aCNumber,
    "adhaarcard": adhaarcard,
    "pancard": pancard,
    "nominee": nominee,
    "nominee_relation": nomineeRelation,
    "nominee_phone": nomineePhone,
    "pincode": pincode,
    "district": district,
    "state": state,
    "country": country,
    "image": image,
    "referalId": referalId,
    "referalFrom": referalFrom,
    "point": point,
    "userType": userType,
    "agentId": agentId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Versions {
  int? android;
  int? ios;

  Versions({this.android, this.ios});

  factory Versions.fromJson(Map<String, dynamic> json) =>
      Versions(android: json["android"], ios: json["ios"]);

  Map<String, dynamic> toJson() => {"android": android, "ios": ios};
}
