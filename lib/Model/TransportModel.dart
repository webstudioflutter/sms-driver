// To parse this JSON data, do
//
//     final transportation = transportationFromJson(jsonString);

import 'dart:convert';

Transportation transportationFromJson(String str) =>
    Transportation.fromJson(json.decode(str));

String transportationToJson(Transportation data) => json.encode(data.toJson());

class Transportation {
  String? message;
  Data? data;
  String? error;

  Transportation({
    this.message,
    this.data,
  });

  Transportation.withError(String errorValue) : error = errorValue;
  factory Transportation.fromJson(Map<String, dynamic> json) => Transportation(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Center? center;
  Center? currentLocation;
  bool? status;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  String? routeName;
  String? transportationId;
  List<Routepath>? routepath;
  int? v;
  DateTime? modifiedAt;
  dynamic modifiedBy;

  Data({
    this.center,
    this.currentLocation,
    this.status,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.routeName,
    this.transportationId,
    this.routepath,
    this.v,
    this.modifiedAt,
    this.modifiedBy,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        center: json["center"] == null ? null : Center.fromJson(json["center"]),
        currentLocation: json["currentLocation"] == null
            ? null
            : Center.fromJson(json["currentLocation"]),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        id: json["_id"],
        schoolId: json["schoolId"],
        routeName: json["routeName"],
        transportationId: json["transportationId"],
        routepath: json["routepath"] == null
            ? []
            : List<Routepath>.from(
                json["routepath"]!.map((x) => Routepath.fromJson(x))),
        v: json["__v"],
        modifiedAt: json["modifiedAt"] == null
            ? null
            : DateTime.parse(json["modifiedAt"]),
        modifiedBy: json["modifiedBy"],
      );

  Map<String, dynamic> toJson() => {
        "center": center?.toJson(),
        "currentLocation": currentLocation?.toJson(),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "routeName": routeName,
        "transportationId": transportationId,
        "routepath": routepath == null
            ? []
            : List<dynamic>.from(routepath!.map((x) => x.toJson())),
        "__v": v,
        "modifiedAt": modifiedAt?.toIso8601String(),
        "modifiedBy": modifiedBy,
      };
}

class Center {
  double? latitude;
  double? longitude;

  Center({
    this.latitude,
    this.longitude,
  });

  factory Center.fromJson(Map<String, dynamic> json) => Center(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Routepath {
  String? id;
  String? locationName;
  List<LocationValue>? locationValues;

  Routepath({
    this.id,
    this.locationName,
    this.locationValues,
  });

  factory Routepath.fromJson(Map<String, dynamic> json) => Routepath(
        id: json["_id"],
        locationName: json["locationName"],
        locationValues: json["locationValues"] == null
            ? []
            : List<LocationValue>.from(
                json["locationValues"]!.map((x) => LocationValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "locationName": locationName,
        "locationValues": locationValues == null
            ? []
            : List<dynamic>.from(locationValues!.map((x) => x.toJson())),
      };
}

class LocationValue {
  String? id;
  double? latitude;
  double? longitude;

  LocationValue({
    this.id,
    this.latitude,
    this.longitude,
  });

  factory LocationValue.fromJson(Map<String, dynamic> json) => LocationValue(
        id: json["_id"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "latitude": latitude,
        "longitude": longitude,
      };
}
