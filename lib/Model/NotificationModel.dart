// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  int? count;
  List<Result>? result;
  String? error;

  NotificationModel({
    this.count,
    this.result,
  });
  NotificationModel.withError(String errorValue) : error = errorValue;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        count: json["count"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  String? notificationStatus;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? token;
  String? title;
  String? body;
  String? image;
  String? userId;
  String? type;
  int? v;

  Result({
    this.notificationStatus,
    this.createdAt,
    this.isArchived,
    this.id,
    this.token,
    this.title,
    this.body,
    this.image,
    this.userId,
    this.type,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        notificationStatus: json["notificationStatus"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        id: json["_id"],
        token: json["token"],
        title: json["title"],
        body: json["body"],
        image: json["image"],
        userId: json["userId"],
        type: json["type"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "notificationStatus": notificationStatus,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "token": token,
        "title": title,
        "body": body,
        "image": image,
        "userId": userId,
        "type": type,
        "__v": v,
      };
}
