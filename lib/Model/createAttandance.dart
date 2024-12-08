// To parse this JSON data, do
//
//     final createAttandance = createAttandanceFromJson(jsonString);

import 'dart:convert';

CreateAttandance createAttandanceFromJson(String str) =>
    CreateAttandance.fromJson(json.decode(str));

String createAttandanceToJson(CreateAttandance data) =>
    json.encode(data.toJson());

class CreateAttandance {
  String? message;
  Result? result;
  String? error;

  CreateAttandance({
    this.message,
    this.result,
  });
  CreateAttandance.withError(String errorValue) : error = errorValue;

  factory CreateAttandance.fromJson(Map<String, dynamic> json) =>
      CreateAttandance(
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result?.toJson(),
      };
}

class Result {
  String? attendaceType;
  bool? status;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  DateTime? date;
  String? time;
  User? user;
  Class? resultClass;
  Transportation? transportation;
  String? createdBy;
  int? v;

  Result({
    this.attendaceType,
    this.status,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.date,
    this.time,
    this.user,
    this.resultClass,
    this.transportation,
    this.createdBy,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        resultClass:
            json["class"] == null ? null : Class.fromJson(json["class"]),
        transportation: json["transportation"] == null
            ? null
            : Transportation.fromJson(json["transportation"]),
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "attendaceType": attendaceType,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "user": user?.toJson(),
        "class": resultClass?.toJson(),
        "transportation": transportation?.toJson(),
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
