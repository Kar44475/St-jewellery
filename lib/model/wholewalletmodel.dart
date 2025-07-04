// To parse this JSON data, do
//
//     final wholewalletmodel = wholewalletmodelFromJson(jsonString);

import 'dart:convert';

Wholewalletmodel wholewalletmodelFromJson(String str) =>
    Wholewalletmodel.fromJson(json.decode(str));

String wholewalletmodelToJson(Wholewalletmodel data) =>
    json.encode(data.toJson());

class Wholewalletmodel {
  Wholewalletmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory Wholewalletmodel.fromJson(Map<String, dynamic> json) =>
      Wholewalletmodel(
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
    required this.wallet,
    this.amountTotal,
    this.gramTotal,
  });

  List<Wallet> wallet;
  var amountTotal;
  var gramTotal;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallet:
            List<Wallet>.from(json["wallet"].map((x) => Wallet.fromJson(x))),
        amountTotal: json["amount_total"],
        gramTotal: json["gram_total"],
      );

  Map<String, dynamic> toJson() => {
        "wallet": List<dynamic>.from(wallet.map((x) => x.toJson())),
        "amount_total": amountTotal,
        "gram_total": gramTotal,
      };
}

class Wallet {
  Wallet({
    required this.schemeName,
    required this.subscriptionId,
    required this.wal,
    required this.amount,
    required this.gram,
  });

  String schemeName;
  int subscriptionId;
  List<Wal> wal;
  dynamic amount;
  dynamic gram;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        schemeName: json["schemeName"],
        subscriptionId: json["SubscriptionId"],
        wal: List<Wal>.from(json["wal"].map((x) => Wal.fromJson(x))),
        amount: json["amount"],
        gram: json["gram"],
      );

  Map<String, dynamic> toJson() => {
        "schemeName": schemeName,
        "SubscriptionId": subscriptionId,
        "wal": List<dynamic>.from(wal.map((x) => x.toJson())),
        "amount": amount,
        "gram": gram,
      };
}

class Wal {
  Wal({
    required this.id,
    required this.voucherNumber,
    required this.userId,
    required this.sheduledDateId,
    required this.subscriptionId,
    required this.gram,
    required this.amount,
    required this.taransactionId,
    required this.paymentDate,
    required this.paidBy,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String voucherNumber;
  int userId;
  int sheduledDateId;
  int subscriptionId;
  String gram;
  String amount;
  String taransactionId;
  DateTime paymentDate;
  int paidBy;
  dynamic paymentMethod;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Wal.fromJson(Map<String, dynamic> json) => Wal(
        id: json["id"],
        voucherNumber: json["voucherNumber"],
        userId: json["UserId"],
        sheduledDateId: json["SheduledDateId"],
        subscriptionId: json["subscriptionId"],
        gram: json["gram"],
        amount: json["amount"],
        taransactionId: json["taransactionId"],
        paymentDate: DateTime.parse(json["paymentDate"]),
        paidBy: json["paidBy"],
        paymentMethod: json["payment_method"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "voucherNumber": voucherNumber,
        "UserId": userId,
        "SheduledDateId": sheduledDateId,
        "subscriptionId": subscriptionId,
        "gram": gram,
        "amount": amount,
        "taransactionId": taransactionId,
        "paymentDate":
            "${paymentDate.year.toString().padLeft(4, '0')}-${paymentDate.month.toString().padLeft(2, '0')}-${paymentDate.day.toString().padLeft(2, '0')}",
        "paidBy": paidBy,
        "payment_method": paymentMethod,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
