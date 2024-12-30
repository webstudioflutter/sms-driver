// To parse this JSON data, do
//
//     final transportationModel = transportationModelFromJson(jsonString);

import 'dart:convert';

TransportationModel transportationModelFromJson(String str) =>
    TransportationModel.fromJson(json.decode(str));

String transportationModelToJson(TransportationModel data) =>
    json.encode(data.toJson());

class TransportationModel {
  int? count;
  List<Result>? result;
  String? error;

  TransportationModel.withError(String errorValue) : error = errorValue;
  TransportationModel({
    this.count,
    this.result,
  });

  factory TransportationModel.fromJson(Map<String, dynamic> json) =>
      TransportationModel(
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
  VehicleDriver? vehicleDriver;
  LiveLocation? liveLocation;
  bool? status;
  String? id;
  String? schoolId;
  List<StoppageLocation>? transportationRoute;
  String? vehicleType;
  String? vehicleNumber;
  int? vehicleCapacity;
  String? vehicleConductor;
  int? conductorNumber;
  String? vehicleCode;
  List<Shift>? shift;
  List<StoppageLocation>? stoppageLocation;

  Result({
    this.vehicleDriver,
    this.liveLocation,
    this.status,
    this.id,
    this.schoolId,
    this.transportationRoute,
    this.vehicleType,
    this.vehicleNumber,
    this.vehicleCapacity,
    this.vehicleConductor,
    this.conductorNumber,
    this.vehicleCode,
    this.shift,
    this.stoppageLocation,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        vehicleDriver: json["vehicleDriver"] == null
            ? null
            : VehicleDriver.fromJson(json["vehicleDriver"]),
        liveLocation: json["liveLocation"] == null
            ? null
            : LiveLocation.fromJson(json["liveLocation"]),
        status: json["status"],
        id: json["_id"],
        schoolId: json["schoolId"],
        transportationRoute: json["transportationRoute"] == null
            ? []
            : List<StoppageLocation>.from(json["transportationRoute"]!
                .map((x) => StoppageLocation.fromJson(x))),
        vehicleType: json["vehicleType"],
        vehicleNumber: json["vehicleNumber"],
        vehicleCapacity: json["vehicleCapacity"],
        vehicleConductor: json["vehicleConductor"],
        conductorNumber: json["conductorNumber"],
        vehicleCode: json["vehicleCode"],
        shift: json["shift"] == null
            ? []
            : List<Shift>.from(json["shift"]!.map((x) => Shift.fromJson(x))),
        stoppageLocation: json["stoppageLocation"] == null
            ? []
            : List<StoppageLocation>.from(json["stoppageLocation"]!
                .map((x) => StoppageLocation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "vehicleDriver": vehicleDriver?.toJson(),
        "liveLocation": liveLocation?.toJson(),
        "status": status,
        "_id": id,
        "schoolId": schoolId,
        "transportationRoute": transportationRoute == null
            ? []
            : List<dynamic>.from(transportationRoute!.map((x) => x.toJson())),
        "vehicleType": vehicleType,
        "vehicleNumber": vehicleNumber,
        "vehicleCapacity": vehicleCapacity,
        "vehicleConductor": vehicleConductor,
        "conductorNumber": conductorNumber,
        "vehicleCode": vehicleCode,
        "shift": shift == null
            ? []
            : List<dynamic>.from(shift!.map((x) => x.toJson())),
        "stoppageLocation": stoppageLocation == null
            ? []
            : List<dynamic>.from(stoppageLocation!.map((x) => x.toJson())),
      };
}

class LiveLocation {
  double? latitude;
  double? longitude;

  LiveLocation({
    this.latitude,
    this.longitude,
  });

  factory LiveLocation.fromJson(Map<String, dynamic> json) => LiveLocation(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Shift {
  String? id;
  String? shiftName;
  String? shiftStartTime;
  String? shiftEndTime;

  Shift({
    this.id,
    this.shiftName,
    this.shiftStartTime,
    this.shiftEndTime,
  });

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        id: json["_id"],
        shiftName: json["shiftName"],
        shiftStartTime: json["shiftStartTime"],
        shiftEndTime: json["shiftEndTime"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "shiftName": shiftName,
        "shiftStartTime": shiftStartTime,
        "shiftEndTime": shiftEndTime,
      };
}

class StoppageLocation {
  StoppageLocationStoppageLocation? stoppageLocation;
  String? id;
  double? longitude;
  double? latitude;
  String? routeLocation;

  StoppageLocation({
    this.stoppageLocation,
    this.id,
    this.longitude,
    this.latitude,
    this.routeLocation,
  });

  factory StoppageLocation.fromJson(Map<String, dynamic> json) =>
      StoppageLocation(
        stoppageLocation: json["stoppageLocation"] == null
            ? null
            : StoppageLocationStoppageLocation.fromJson(
                json["stoppageLocation"]),
        id: json["_id"],
        longitude: json["longitude"]?.toDouble(),
        latitude: json["latitude"]?.toDouble(),
        routeLocation: json["routeLocation"],
      );

  Map<String, dynamic> toJson() => {
        "stoppageLocation": stoppageLocation?.toJson(),
        "_id": id,
        "longitude": longitude,
        "latitude": latitude,
        "routeLocation": routeLocation,
      };
}

class StoppageLocationStoppageLocation {
  String? id;
  String? busRoute;
  int? busCharge;

  StoppageLocationStoppageLocation({
    this.id,
    this.busRoute,
    this.busCharge,
  });

  factory StoppageLocationStoppageLocation.fromJson(
          Map<String, dynamic> json) =>
      StoppageLocationStoppageLocation(
        id: json["_id"],
        busRoute: json["busRoute"],
        busCharge: json["busCharge"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "busRoute": busRoute,
        "busCharge": busCharge,
      };
}

class VehicleDriver {
  String? id;
  String? fullName;
  String? lisenceNumber;
  int? contactNumber;

  VehicleDriver({
    this.id,
    this.fullName,
    this.lisenceNumber,
    this.contactNumber,
  });

  factory VehicleDriver.fromJson(Map<String, dynamic> json) => VehicleDriver(
        id: json["_id"],
        fullName: json["fullName"],
        lisenceNumber: json["lisenceNumber"],
        contactNumber: json["contactNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
        "lisenceNumber": lisenceNumber,
        "contactNumber": contactNumber,
      };
}
