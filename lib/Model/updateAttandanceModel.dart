// To parse this JSON data, do
//
//     final updateAttandanceModel = updateAttandanceModelFromJson(jsonString);

import 'dart:convert';

UpdateAttandanceModel updateAttandanceModelFromJson(String str) =>
    UpdateAttandanceModel.fromJson(json.decode(str));

String updateAttandanceModelToJson(UpdateAttandanceModel data) =>
    json.encode(data.toJson());

class UpdateAttandanceModel {
  String? message;
  List<Result>? result;
  int? count;
  String? error;

  UpdateAttandanceModel({
    this.message,
    this.result,
    this.count,
  });
  UpdateAttandanceModel.withError(String errorValue) : error = errorValue;

  factory UpdateAttandanceModel.fromJson(Map<String, dynamic> json) =>
      UpdateAttandanceModel(
        message: json["message"],
        result: json["result"] == null
            ? []
            : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result == null
            ? []
            : List<dynamic>.from(result!.map((x) => x.toJson())),
        "count": count,
      };
}

class Result {
  User? user;
  Transportation? transportation;
  Class? resultClass;
  String? attendaceType;
  bool? status;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  DateTime? date;
  String? time;
  String? createdBy;
  int? v;

  Result({
    this.user,
    this.transportation,
    this.resultClass,
    this.attendaceType,
    this.status,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.date,
    this.time,
    this.createdBy,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        transportation: json["transportation"] == null
            ? null
            : Transportation.fromJson(json["transportation"]),
        resultClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
        attendaceType: json["attendaceType"],
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        id: json["_id"],
        schoolId: json["schoolId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"],
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "transportation": transportation?.toJson(),
        "class": resultClass?.toJson(),
        "attendaceType": attendaceType,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "createdBy": createdBy,
        "__v": v,
      };
}

class Class {
  String? id;
  String? className;

  Class({
    this.id,
    this.className,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["_id"],
        className: json["className"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "className": className,
      };
}

class Transportation {
  String? id;
  String? name;

  Transportation({
    this.id,
    this.name,
  });

  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}

class User {
  String? id;
  String? name;
  String? profileImage;
  String? pickDropLocation;

  User({
    this.id,
    this.name,
    this.profileImage,
    this.pickDropLocation,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
        profileImage: json["profileImage"],
        pickDropLocation: json["pickDropLocation"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profileImage": profileImage,
        "pickDropLocation": pickDropLocation,
      };
}
