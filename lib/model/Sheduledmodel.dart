// To parse this JSON data, do
//
//     final sheduledmodel = sheduledmodelFromJson(jsonString);

import 'dart:convert';

Sheduledmodel sheduledmodelFromJson(String str) =>
    Sheduledmodel.fromJson(json.decode(str));

String sheduledmodelToJson(Sheduledmodel data) => json.encode(data.toJson());

class Sheduledmodel {
  bool? success;
  String? message;
  Data? data;

  Sheduledmodel({this.success, this.message, this.data});

  factory Sheduledmodel.fromJson(Map<String, dynamic> json) => Sheduledmodel(
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
  String? status;
  var half;
  var halfPaymentSum;
  var average;
  List<LastDate>? sheduledList;
  List<LastDate>? upcomingPayment;
  List<LastDate>? unPaidPayment;
  List<LastDate>? paidPayment;
  String? monthlyAmont;
  String? amountTo;
  int? paymentType;
  String? todayRate;
  double? todayEarnings;
  var sumAmount;
  var sumGram;
  String? schemeName;
  int? notificationCount;
  Termsandcondtion? termsandcondtion;
  Versions? versions;
  List<String>? referalId;
  int? schemetype;
  Subs? subs;
  List<LastDate>? lastDate;
  LastPaymentStatus? lastPaymentStatus;

  Data({
    this.status,
    this.half,
    this.halfPaymentSum,
    this.average,
    this.sheduledList,
    this.upcomingPayment,
    this.unPaidPayment,
    this.paidPayment,
    this.monthlyAmont,
    this.amountTo,
    this.paymentType,
    this.todayRate,
    this.todayEarnings,
    this.sumAmount,
    this.sumGram,
    this.schemeName,
    this.notificationCount,
    this.termsandcondtion,
    this.versions,
    this.referalId,
    this.schemetype,
    this.subs,
    this.lastDate,
    this.lastPaymentStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    half: json["half"],
    halfPaymentSum: json["half_payment_sum"],
    average: json["average"],
    sheduledList: json["SheduledList"] == null
        ? []
        : List<LastDate>.from(
            json["SheduledList"]!.map((x) => LastDate.fromJson(x)),
          ),
    upcomingPayment: json["UpcomingPayment"] == null
        ? []
        : List<LastDate>.from(
            json["UpcomingPayment"]!.map((x) => LastDate.fromJson(x)),
          ),
    unPaidPayment: json["unPaidPayment"] == null
        ? []
        : List<LastDate>.from(
            json["unPaidPayment"]!.map((x) => LastDate.fromJson(x)),
          ),
    paidPayment: json["paidPayment"] == null
        ? []
        : List<LastDate>.from(
            json["paidPayment"]!.map((x) => LastDate.fromJson(x)),
          ),
    monthlyAmont: json["MonthlyAmont"],
    amountTo: json["Amount_to"],
    paymentType: json["payment_type"],
    todayRate: json["TodayRate"],
    todayEarnings: json["todayEarnings"]?.toDouble(),
    sumAmount: json["sum_amount"],
    sumGram: json["sum_gram"],
    schemeName: json["schemeName"],
    notificationCount: json["NotificationCount"],
    termsandcondtion: json["termsandcondtion"] == null
        ? null
        : Termsandcondtion.fromJson(json["termsandcondtion"]),
    versions: json["versions"] == null
        ? null
        : Versions.fromJson(json["versions"]),
    referalId: json["referalId"] == null
        ? []
        : List<String>.from(json["referalId"]!.map((x) => x)),
    schemetype: json["scheme_type"],
    subs: json["subs"] == null ? null : Subs.fromJson(json["subs"]),
    lastDate: json["Last_date"] == null
        ? []
        : List<LastDate>.from(
            json["Last_date"]!.map((x) => LastDate.fromJson(x)),
          ),
    lastPaymentStatus: json["last_payment_status"] == null
        ? null
        : LastPaymentStatus.fromJson(json["last_payment_status"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "half": half,
    "half_payment_sum": halfPaymentSum,
    "average": average,
    "SheduledList": sheduledList == null
        ? []
        : List<dynamic>.from(sheduledList!.map((x) => x.toJson())),
    "UpcomingPayment": upcomingPayment == null
        ? []
        : List<dynamic>.from(upcomingPayment!.map((x) => x.toJson())),
    "unPaidPayment": unPaidPayment == null
        ? []
        : List<dynamic>.from(unPaidPayment!.map((x) => x.toJson())),
    "paidPayment": paidPayment == null
        ? []
        : List<dynamic>.from(paidPayment!.map((x) => x.toJson())),
    "MonthlyAmont": monthlyAmont,
    "Amount_to": amountTo,
    "payment_type": paymentType,
    "TodayRate": todayRate,
    "todayEarnings": todayEarnings,
    "sum_amount": sumAmount,
    "sum_gram": sumGram,
    "schemeName": schemeName,
    "NotificationCount": notificationCount,
    "termsandcondtion": termsandcondtion?.toJson(),
    "versions": versions?.toJson(),
    "referalId": referalId == null
        ? []
        : List<dynamic>.from(referalId!.map((x) => x)),
    "scheme_type": schemetype,
    "subs": subs?.toJson(),
    "Last_date": lastDate == null
        ? []
        : List<dynamic>.from(lastDate!.map((x) => x.toJson())),
    "last_payment_status": lastPaymentStatus?.toJson(),
  };
}

class LastDate {
  int? id;
  int? branchId;
  int? userId;
  int? schemeId;
  int? schemeAmountId;
  int? subscriptionId;
  DateTime? paymentStartDates;
  DateTime? paymentEndDates;
  int? order;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? upiStatus;
  int? sheduledStatus;

  LastDate({
    this.id,
    this.branchId,
    this.userId,
    this.schemeId,
    this.schemeAmountId,
    this.subscriptionId,
    this.paymentStartDates,
    this.paymentEndDates,
    this.order,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.upiStatus,
    this.sheduledStatus,
  });

  factory LastDate.fromJson(Map<String, dynamic> json) => LastDate(
    id: json["id"],
    branchId: json["branchId"],
    userId: json["UserId"],
    schemeId: json["SchemeId"],
    schemeAmountId: json["SchemeAmountId"],
    subscriptionId: json["subscriptionId"],
    paymentStartDates: json["PaymentStartDates"] == null
        ? null
        : DateTime.parse(json["PaymentStartDates"]),
    paymentEndDates: json["PaymentEndDates"] == null
        ? null
        : DateTime.parse(json["PaymentEndDates"]),
    order: json["order"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    upiStatus: json["upi_status"],
    sheduledStatus: json["sheduled_status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branchId": branchId,
    "UserId": userId,
    "SchemeId": schemeId,
    "SchemeAmountId": schemeAmountId,
    "subscriptionId": subscriptionId,
    "PaymentStartDates":
        "${paymentStartDates!.year.toString().padLeft(4, '0')}-${paymentStartDates!.month.toString().padLeft(2, '0')}-${paymentStartDates!.day.toString().padLeft(2, '0')}",
    "PaymentEndDates":
        "${paymentEndDates!.year.toString().padLeft(4, '0')}-${paymentEndDates!.month.toString().padLeft(2, '0')}-${paymentEndDates!.day.toString().padLeft(2, '0')}",
    "order": order,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "upi_status": upiStatus,
    "sheduled_status": sheduledStatus,
  };
}

class LastPaymentStatus {
  int? id;
  int? userId;
  int? subscriptionId;
  int? lastpaymentStatus;
  DateTime? createdAt;
  DateTime? updatedAt;

  LastPaymentStatus({
    this.id,
    this.userId,
    this.subscriptionId,
    this.lastpaymentStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory LastPaymentStatus.fromJson(Map<String, dynamic> json) =>
      LastPaymentStatus(
        id: json["id"],
        userId: json["UserId"],
        subscriptionId: json["subscriptionId"],
        lastpaymentStatus: json["lastpaymentStatus"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "UserId": userId,
    "subscriptionId": subscriptionId,
    "lastpaymentStatus": lastpaymentStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Subs {
  int? id;
  int? branchId;
  int? userId;
  int? schemeId;
  int? schemeAmountId;
  DateTime? startDate;
  dynamic endDate;
  int? subscriptionType;
  int? schemetype;
  DateTime? dateCheck;
  int? status;
  dynamic userSchemeName;
  int? termsId;
  DateTime? createdAt;
  DateTime? updatedAt;

  Subs({
    this.id,
    this.branchId,
    this.userId,
    this.schemeId,
    this.schemeAmountId,
    this.startDate,
    this.endDate,
    this.subscriptionType,
    this.schemetype,
    this.dateCheck,
    this.status,
    this.userSchemeName,
    this.termsId,
    this.createdAt,
    this.updatedAt,
  });

  factory Subs.fromJson(Map<String, dynamic> json) => Subs(
    id: json["id"],
    branchId: json["branchId"],
    userId: json["UserId"],
    schemeId: json["SchemeId"],
    schemeAmountId: json["SchemeAmountId"],
    startDate: json["StartDate"] == null
        ? null
        : DateTime.parse(json["StartDate"]),
    endDate: json["EndDate"],
    subscriptionType: json["subscription_type"],
    schemetype: json["scheme_type"],
    dateCheck: json["date_check"] == null
        ? null
        : DateTime.parse(json["date_check"]),
    status: json["status"],
    userSchemeName: json["user_scheme_name"],
    termsId: json["termsId"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "branchId": branchId,
    "UserId": userId,
    "SchemeId": schemeId,
    "SchemeAmountId": schemeAmountId,
    "StartDate":
        "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "EndDate": endDate,
    "subscription_type": subscriptionType,
    "scheme_type": schemetype,
    "date_check":
        "${dateCheck!.year.toString().padLeft(4, '0')}-${dateCheck!.month.toString().padLeft(2, '0')}-${dateCheck!.day.toString().padLeft(2, '0')}",
    "status": status,
    "user_scheme_name": userSchemeName,
    "termsId": termsId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Termsandcondtion {
  int? id;
  int? branchId;
  String? title;
  String? description;
  dynamic createdAt;
  dynamic updatedAt;

  Termsandcondtion({
    this.id,
    this.branchId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Termsandcondtion.fromJson(Map<String, dynamic> json) =>
      Termsandcondtion(
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
  int? android;
  int? ios;

  Versions({this.android, this.ios});

  factory Versions.fromJson(Map<String, dynamic> json) =>
      Versions(android: json["android"], ios: json["ios"]);

  Map<String, dynamic> toJson() => {"android": android, "ios": ios};
}
