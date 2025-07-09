// To parse this JSON data, do
//
//     final paymentdetailsmodel = paymentdetailsmodelFromJson(jsonString);

import 'dart:convert';

Paymentdetailsmodel paymentdetailsmodelFromJson(String str) =>
    Paymentdetailsmodel.fromJson(json.decode(str));

String paymentdetailsmodelToJson(Paymentdetailsmodel data) =>
    json.encode(data.toJson());

class Paymentdetailsmodel {
  bool success;
  String message;
  Data data;

  Paymentdetailsmodel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Paymentdetailsmodel.fromJson(Map<String, dynamic> json) =>
      Paymentdetailsmodel(
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
  List<PaymentsList> paymentsList;
  var sumAmount;
  var sumGram;
  int totalInstallment;
  String schemeName;
  int schemeType;
  List<String> totalPoint;

  Data({
    required this.paymentsList,
    this.sumAmount,
    this.sumGram,
    required this.totalInstallment,
    required this.schemeName,
    required this.schemeType,
    required this.totalPoint,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    paymentsList: List<PaymentsList>.from(
      json["paymentsList"].map((x) => PaymentsList.fromJson(x)),
    ),
    sumAmount: json["sum_amount"],
    sumGram: json["sum_gram"],
    totalInstallment: json["totalInstallment"],
    schemeName: json["SchemeName"],
    schemeType: json["SchemeType"],
    totalPoint: List<String>.from(json["TotalPoint"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "paymentsList": List<dynamic>.from(paymentsList.map((x) => x.toJson())),
    "sum_amount": sumAmount,
    "sum_gram": sumGram,
    "totalInstallment": totalInstallment,
    "SchemeName": schemeName,
    "SchemeType": schemeType,
    "TotalPoint": List<dynamic>.from(totalPoint.map((x) => x)),
  };
}

class PaymentsList {
  int id;
  int branchId;
  String voucherNumber;
  int userId;
  int sheduledDateId;
  int subscriptionId;
  String gram;
  String amount;
  String taransactionId;
  DateTime paymentDate;
  int paidBy;
  dynamic note;
  int paymentMode;
  int? paymentMethod;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  PaymentsList({
    required this.id,
    required this.branchId,
    required this.voucherNumber,
    required this.userId,
    required this.sheduledDateId,
    required this.subscriptionId,
    required this.gram,
    required this.amount,
    required this.taransactionId,
    required this.paymentDate,
    required this.paidBy,
    this.note,
    required this.paymentMode,
    this.paymentMethod,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentsList.fromJson(Map<String, dynamic> json) => PaymentsList(
    id: json["id"],
    branchId: json["branchId"],
    voucherNumber: json["voucherNumber"],
    userId: json["UserId"],
    sheduledDateId: json["SheduledDateId"],
    subscriptionId: json["subscriptionId"],
    gram: json["gram"],
    amount: json["amount"],
    taransactionId: json["taransactionId"],
    paymentDate: DateTime.parse(json["paymentDate"]),
    paidBy: json["paidBy"],
    note: json["note"],
    paymentMode: json["paymentMode"],
    paymentMethod: json["payment_method"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branchId": branchId,
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
    "note": note,
    "paymentMode": paymentMode,
    "payment_method": paymentMethod,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
