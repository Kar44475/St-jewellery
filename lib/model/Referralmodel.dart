// To parse this JSON data, do
//
//     final referralmodel = referralmodelFromJson(jsonString);

import 'dart:convert';

Referralmodel referralmodelFromJson(String str) =>
    Referralmodel.fromJson(json.decode(str));

String referralmodelToJson(Referralmodel data) => json.encode(data.toJson());

class Referralmodel {
  Referralmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Referralmodel.fromJson(Map<String, dynamic> json) => Referralmodel(
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
  Data({required this.referal, required this.point, required this.referedList});

  Referal referal;
  double point;
  List<ReferedList> referedList;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    referal: Referal.fromJson(json["Referal"]),
    point: json["point"] == null ? null : json["point"].toDouble(),
    referedList: List<ReferedList>.from(
      json["ReferedList"].map((x) => ReferedList.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "Referal": referal == null ? null : referal.toJson(),
    "point": point,
    "ReferedList": referedList == null
        ? null
        : List<dynamic>.from(referedList.map((x) => x.toJson())),
  };
}

class Referal {
  Referal({
    required this.id,
    required this.userId,
    required this.referalId,
    required this.referalFrom,
    required this.point,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String referalId;
  var referalFrom;
  var point;
  DateTime createdAt;
  DateTime updatedAt;

  factory Referal.fromJson(Map<String, dynamic> json) => Referal(
    id: json["id"],
    userId: json["UserId"],
    referalId: json["referalId"],
    referalFrom: json["referalFrom"],
    point: json["point"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "UserId": userId,
    "referalId": referalId,
    "referalFrom": referalFrom,
    "point": point,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}

class ReferedList {
  ReferedList({
    required this.userId,
    required this.name,
    required this.phone,
    required this.paymentDates,
  });

  int userId;
  String name;
  String phone;
  List<PaymentDate> paymentDates;

  factory ReferedList.fromJson(Map<String, dynamic> json) => ReferedList(
    userId: json["UserId"],
    name: json["name"],
    phone: json["phone"],
    paymentDates: List<PaymentDate>.from(
      json["payment_dates"].map((x) => PaymentDate.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "name": name,
    "phone": phone,
    "payment_dates": paymentDates == null
        ? null
        : List<dynamic>.from(paymentDates.map((x) => x.toJson())),
  };
}

class PaymentDate {
  PaymentDate({
    required this.id,
    required this.userId,
    required this.schemeId,
    required this.schemeAmountId,
    required this.subscriptionId,
    required this.paymentStartDates,
    required this.paymentEndDates,
    required this.order,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  int schemeId;
  int schemeAmountId;
  int subscriptionId;
  DateTime paymentStartDates;
  DateTime paymentEndDates;
  int order;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory PaymentDate.fromJson(Map<String, dynamic> json) => PaymentDate(
    id: json["id"],
    userId: json["UserId"],
    schemeId: json["SchemeId"],
    schemeAmountId: json["SchemeAmountId"],
    subscriptionId: json["subscriptionId"],
    paymentStartDates: DateTime.parse(json["PaymentStartDates"]),
    paymentEndDates: DateTime.parse(json["PaymentEndDates"]),
    order: json["order"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "UserId": userId,
    "SchemeId": schemeId,
    "SchemeAmountId": schemeAmountId,
    "subscriptionId": subscriptionId,
    "PaymentStartDates": paymentStartDates == null
        ? null
        : "${paymentStartDates.year.toString().padLeft(4, '0')}-${paymentStartDates.month.toString().padLeft(2, '0')}-${paymentStartDates.day.toString().padLeft(2, '0')}",
    "PaymentEndDates": paymentEndDates == null
        ? null
        : "${paymentEndDates.year.toString().padLeft(4, '0')}-${paymentEndDates.month.toString().padLeft(2, '0')}-${paymentEndDates.day.toString().padLeft(2, '0')}",
    "order": order,
    "status": status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
  };
}
