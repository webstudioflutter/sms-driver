// To parse this JSON data, do
//
//     final billModel = billModelFromJson(jsonString);

import 'dart:convert';

BillModel billModelFromJson(String str) => BillModel.fromJson(json.decode(str));

String billModelToJson(BillModel data) => json.encode(data.toJson());

class BillModel {
  int? count;
  List<Result>? result;
  String? error;

  BillModel({
    this.count,
    this.result,
  });
  BillModel.withError(String errorValue) : error = errorValue;

  factory BillModel.fromJson(Map<String, dynamic> json) => BillModel(
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
  Info? driverInfo;
  Info? vehicleInfo;
  List<String>? partsUsed;
  List<String>? oldPartsImages;
  List<String>? newPartsImages;
  bool? status;
  DateTime? createdAt;
  bool? isArchived;
  String? id;
  String? schoolId;
  dynamic date;
  String? expenseType;
  String? billType;
  String? billTitle;
  int? billAmount;
  dynamic nextServiceDate;
  String? billImage;
  String? createdBy;
  int? v;

  Result({
    this.driverInfo,
    this.vehicleInfo,
    this.partsUsed,
    this.oldPartsImages,
    this.newPartsImages,
    this.status,
    this.createdAt,
    this.isArchived,
    this.id,
    this.schoolId,
    this.date,
    this.expenseType,
    this.billType,
    this.billTitle,
    this.billAmount,
    this.nextServiceDate,
    this.billImage,
    this.createdBy,
    this.v,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        driverInfo: json["driverInfo"] == null
            ? null
            : Info.fromJson(json["driverInfo"]),
        vehicleInfo: json["vehicleInfo"] == null
            ? null
            : Info.fromJson(json["vehicleInfo"]),
        partsUsed: json["partsUsed"] == null
            ? []
            : List<String>.from(json["partsUsed"]!.map((x) => x)),
        oldPartsImages: json["oldPartsImages"] == null
            ? []
            : List<String>.from(json["oldPartsImages"]!.map((x) => x)),
        newPartsImages: json["newPartsImages"] == null
            ? []
            : List<String>.from(json["newPartsImages"]!.map((x) => x)),
        status: json["status"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        isArchived: json["isArchived"],
        id: json["_id"],
        schoolId: json["schoolId"],
        date: json["date"],
        expenseType: json["expenseType"],
        billType: json["billType"],
        billTitle: json["billTitle"],
        billAmount: json["billAmount"],
        nextServiceDate: json["nextServiceDate"],
        billImage: json["billImage"],
        createdBy: json["createdBy"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "driverInfo": driverInfo?.toJson(),
        "vehicleInfo": vehicleInfo?.toJson(),
        "partsUsed": partsUsed == null
            ? []
            : List<dynamic>.from(partsUsed!.map((x) => x)),
        "oldPartsImages": oldPartsImages == null
            ? []
            : List<dynamic>.from(oldPartsImages!.map((x) => x)),
        "newPartsImages": newPartsImages == null
            ? []
            : List<dynamic>.from(newPartsImages!.map((x) => x)),
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "isArchived": isArchived,
        "_id": id,
        "schoolId": schoolId,
        "date": date,
        "expenseType": expenseType,
        "billType": billType,
        "billTitle": billTitle,
        "billAmount": billAmount,
        "nextServiceDate": nextServiceDate,
        "billImage": billImage,
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
