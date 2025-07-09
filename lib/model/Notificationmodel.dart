// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  Data data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
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
  Data({required this.status, required this.notification});

  String status;
  List<Notification> notification;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    notification: List<Notification>.from(
      json["notification"].map((x) => Notification.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "notification": notification == null
        ? null
        : List<dynamic>.from(notification.map((x) => x.toJson())),
  };
}

class Notification {
  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.userId,
    required this.subscriptionId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String description;
  int userId;
  int subscriptionId;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    userId: json["UserId"],
    subscriptionId: json["subscriptionId"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "UserId": userId,
    "subscriptionId": subscriptionId,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
