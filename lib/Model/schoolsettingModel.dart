// To parse this JSON data, do
//
//     final schoolsettingModel = schoolsettingModelFromJson(jsonString);

import 'dart:convert';

SchoolsettingModel schoolsettingModelFromJson(String str) =>
    SchoolsettingModel.fromJson(json.decode(str));

String schoolsettingModelToJson(SchoolsettingModel data) =>
    json.encode(data.toJson());

class SchoolsettingModel {
  int? count;
  List<Result>? result;
  String? error;

  SchoolsettingModel({
    this.count,
    this.result,
  });
  SchoolsettingModel.withError(String errorValue) : error = errorValue;

  factory SchoolsettingModel.fromJson(Map<String, dynamic> json) =>
      SchoolsettingModel(
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
  List<String>? offDays;
  bool? status;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  String? schoolLogo;
  List<Shift>? shift;
  String? contactNo;
  String? createdBy;
  int? v;

  Result({
    this.offDays,
    this.status,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.schoolLogo,
    this.shift,
    this.contactNo,
    this.createdBy,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        offDays: json["offDays"] == null
            ? []
            : List<String>.from(json["offDays"]!.map((x) => x)),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        id: json["_id"],
        schoolId: json["schoolId"],
        schoolLogo: json["schoolLogo"],
        shift: json["shift"] == null
            ? []
            : List<Shift>.from(json["shift"]!.map((x) => Shift.fromJson(x))),
        contactNo: json["contactNo"] ?? "",
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "offDays":
            offDays == null ? [] : List<dynamic>.from(offDays!.map((x) => x)),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "schoolLogo": schoolLogo,
        "shift": shift == null
            ? []
            : List<dynamic>.from(shift!.map((x) => x.toJson())),
        "contactNo": contactNo,
        "createdBy": createdBy,
        "__v": v,
      };
}

class Shift {
  String? id;
  String? shift;
  String? startTime;
  String? endTime;

  Shift({
    this.id,
    this.shift,
    this.startTime,
    this.endTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["_id"],
        shift: json["shift"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "shift": shift,
        "startTime": startTime,
        "endTime": endTime,
      };
}
