// To parse this JSON data, do
//
//     final startStopRoute = startStopRouteFromJson(jsonString);

import 'dart:convert';

StartStopRoute startStopRouteFromJson(String str) =>
    StartStopRoute.fromJson(json.decode(str));

String startStopRouteToJson(StartStopRoute data) => json.encode(data.toJson());

class StartStopRoute {
  String? message;
  Result? result;
  String? error;

  StartStopRoute({
    this.message,
    this.result,
  });
  StartStopRoute.withError(String errorValue) : error = errorValue;

  factory StartStopRoute.fromJson(Map<String, dynamic> json) => StartStopRoute(
        message: json["message"],
        result: json["result"] == null ? null : Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "result": result?.toJson(),
      };
}

class Result {
  String? isPickedDrop;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  DateTime? date;
  int? readingOnStart;
  int? readingOnStop;
  int? totalReading;
  Info? driverInfo;
  Info? vehicleInfo;
  String? createdBy;
  int? v;

  Result({
    this.isPickedDrop,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.date,
    this.readingOnStart,
    this.readingOnStop,
    this.totalReading,
    this.driverInfo,
    this.vehicleInfo,
    this.createdBy,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        isPickedDrop: json["isPickedDrop"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        id: json["_id"],
        schoolId: json["schoolId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        readingOnStart: json["readingOnStart"],
        readingOnStop: json["readingOnStop"],
        totalReading: json["totalReading"],
        driverInfo: json["driverInfo"] == null
            ? null
            : Info.fromJson(json["driverInfo"]),
        vehicleInfo: json["vehicleInfo"] == null
            ? null
            : Info.fromJson(json["vehicleInfo"]),
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "isPickedDrop": isPickedDrop,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "readingOnStart": readingOnStart,
        "readingOnStop": readingOnStop,
        "totalReading": totalReading,
        "driverInfo": driverInfo?.toJson(),
        "vehicleInfo": vehicleInfo?.toJson(),
        "createdBy": createdBy,
        "__v": v,
      };
}

class Info {
  String? id;
  String? name;

  Info({
    this.id,
    this.name,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
      };
}
